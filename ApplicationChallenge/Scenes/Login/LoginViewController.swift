//
//  LoginViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayAlert()
    func diplayCountryList()
    func displayCountry(viewModel: Login.Country.ViewModel)
}

class LoginViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var selectCountryButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        LoginConfigurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.viewControllerStateChanged(state: .viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - Private methods
    private func setup() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        selectCountryButton.setTitle("", for: .normal)
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @IBAction private func pressButton(_ sender: UIButton) {
        switch sender {
        case selectCountryButton:
            interactor?.userActionOccured(userAction: .selectCountry)
        case loginButton:
            interactor?.userActionOccured(userAction: .loginPressed)
        default: break
        }
    }
}
// MARK: - LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func displayAlert() {
        
    }
    
    func diplayCountryList() {
        router?.navigateToCountryList()
    }
    
    func displayCountry(viewModel: Login.Country.ViewModel) {
        countryTextField.text = viewModel.name
    }

}
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            interactor?.userActionOccured(userAction: .enterUsername)
        } else if textField == passwordTextField {
            interactor?.userActionOccured(userAction: .enterPassword)
        }
    }
}
