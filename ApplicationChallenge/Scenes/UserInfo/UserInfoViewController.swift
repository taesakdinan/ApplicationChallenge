//
//  UserInfoViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Parchment

protocol UserInfoDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserInfo.Something.ViewModel)
}

class UserInfoViewController: UIViewController, UserInfoDisplayLogic {
    var interactor: UserInfoBusinessLogic?
    var router: (NSObjectProtocol & UserInfoRoutingLogic & UserInfoDataPassing)?
    
    
    class func instantiateViewController() -> UserInfoViewController {
        let storyboard = UIStoryboard(name: "UserInfo", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        return destinationVC
    }
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        UserInfoConfigurator.configure(viewController: self)
    }
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = UIViewController()
         let secondViewController = UIViewController()
        let pagingViewController = PagingViewController(viewControllers: [
          firstViewController,
          secondViewController
        ])
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        doSomething()
    }
    
    // MARK: Do something
    
//    @IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = UserInfo.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: UserInfo.Something.ViewModel) {
//        nameTextField.text = viewModel.name
    }
}
