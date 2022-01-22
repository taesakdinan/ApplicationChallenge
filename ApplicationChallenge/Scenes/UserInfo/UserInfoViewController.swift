//
//  UserInfoViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit
import Parchment

protocol UserInfoDisplayLogic: AnyObject {
    func displayLoading(viewModel: UserInfo.Loading.ViewModel)
    func displayUsersInfo(viewModel: UserInfo.UserInfo.ViewModel)
}

class UserInfoViewController: UIViewController {
    
    class func instantiateViewController() -> UserInfoViewController {
        let storyboard = UIStoryboard(name: "UserInfo", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        return destinationVC
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    var interactor: UserInfoBusinessLogic?
    var router: (NSObjectProtocol & UserInfoRoutingLogic & UserInfoDataPassing)?
    private var pagingViewController = PagingViewController()
    private var dataList: [User] = [] {
        didSet {
            pagingViewController.reloadData()
        }
    }
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        UserInfoConfigurator.configure(viewController: self)
    }
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.viewControllerStateChanged(state: .viewDidLoad)
    }
    
    private func setup() {
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.statusBarHeight),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        pagingViewController.dataSource = self
    }
}

extension UserInfoViewController: UserInfoDisplayLogic {
    func displayLoading(viewModel: UserInfo.Loading.ViewModel) {
        if viewModel.isShow {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func displayUsersInfo(viewModel: UserInfo.UserInfo.ViewModel) {
        dataList = viewModel.users
    }
}

extension UserInfoViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        dataList.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let vc = UserInfoDetailViewController.instantiateViewController()
        vc.userInfo = dataList[index]
        return vc
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let id = dataList[index].id ?? 0
        return PagingIndexItem(index: index, title: "\(id)")
    }
}
