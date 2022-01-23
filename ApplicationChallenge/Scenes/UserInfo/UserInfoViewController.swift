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
    func displayAlert(viewModel: UserInfo.Alert.ViewModel)
    func displayEmptyAlert(viewModel: UserInfo.Alert.ViewModel)
    func displayUsersInfo(viewModel: UserInfo.UserInfo.ViewModel)
    func closeApplication()
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
    
    func displayAlert(viewModel: UserInfo.Alert.ViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .destructive) { [weak self] _ in
            guard let self = self, let interactor = self.interactor else { return }
            interactor.userActionOccured(userAction: .closeApplitionPressed)
        }
        let retry = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let self = self, let interactor = self.interactor else { return }
            interactor.userActionOccured(userAction: .retryPressed)
        }
        alert.addAction(close)
        alert.addAction(retry)
        present(alert, animated: true)
    }
    
    func displayEmptyAlert(viewModel: UserInfo.Alert.ViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func displayUsersInfo(viewModel: UserInfo.UserInfo.ViewModel) {
        dataList = viewModel.users
    }
    
    func closeApplication() {
        exit(0)
    }
}

extension UserInfoViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        dataList.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        UserInfoDetailViewController.instantiateViewController(userInfo: dataList[index])
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let id = dataList[index].id ?? 0
        return PagingIndexItem(index: index, title: "\(id)")
    }
}
