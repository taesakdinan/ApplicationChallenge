//
//  DetailViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: Detail.Something.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic {
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
//    @IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = Detail.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Detail.Something.ViewModel) {
//        nameTextField.text = viewModel.name
    }
}
