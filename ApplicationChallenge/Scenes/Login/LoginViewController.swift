//
//  LoginViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayAlert(viewModel: Login.Alert.ViewModel)
    func displayCountry(viewModel: Login.Country.ViewModel)
    func displayCountryList()
    func displayDetailScene()
    func clearPassword()
}

class LoginViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var selectCountryButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    class func instantiateViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return destinationVC
    }
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    var coordinator: LoginCoordinatable?
    
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
        let userInfo = notification.userInfo as? [String: Any]
        guard let keyboardInfo = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
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
            let request = Login.InputData.Request(username: usernameTextField.text,
                                                  password: passwordTextField.text,
                                                  country: countryTextField.text)
            interactor?.userActionOccured(userAction: .loginPressed(request: request))
        default: break
        }
    }
}
// MARK: - LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func displayAlert(viewModel: Login.Alert.ViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func displayCountry(viewModel: Login.Country.ViewModel) {
        countryTextField.text = viewModel.name
    }
    
    func displayCountryList() {
        router?.navigateToCountryList()
    }
    
    func displayDetailScene() {
        router?.navigateToDetailScene()
    }
    
    func clearPassword() {
        passwordTextField.text = nil
    }

}
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        string != " "
    }
}
