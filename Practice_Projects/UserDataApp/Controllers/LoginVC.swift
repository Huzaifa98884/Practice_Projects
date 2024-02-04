//
//  LoginVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 13/07/2023.
//

import UIKit
import Toast_Swift
 class LoginVC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var totalHeight: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField(usernameTextField)
        customizeTextField(passwordTextField)
        // Create a style object for the toast
        var style = ToastStyle()
        // Set the background color
        style.backgroundColor = .white
        // Set the text color
        style.messageColor = .systemTeal.withAlphaComponent(0.7)
        // Apply the style to the toast manager
        ToastManager.shared.style = style
        removeNavigationBar()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let viewController = self.presentedViewController ?? self.children.last {
            print("Code reached here")
            return viewController.preferredStatusBarStyle
        } else {
            print("Code did not reached here")
            return .default
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
        
       public func isPasswordValid(_ password: String) -> Bool {
            return password.count > 7
        }
        
    @IBAction func loginButtonPressed(_ sender: Any) {
        if let user = usernameTextField.text, !user.isEmpty,
           let pass = passwordTextField.text, !pass.isEmpty {
            checkUser(username: user, password: pass)
        } else {
            DispatchQueue.main.async {
                // Show the toast message
                self.view.makeToast("Please fill all the fields", duration: 2.0, position: .bottom)
            }
        }

    }
}

extension LoginVC{
    func emptyFields(){
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    func customizeTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        // Add more properties as needed
    }

    func removeNavigationBar(){
        navigationItem.setHidesBackButton(true, animated: false)
        if let navigationController = navigationController {
                navigationController.interactivePopGestureRecognizer?.delegate = self
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
            }
    }
    
    func checkUser(username: String , password: String){
        // Fetch data from the API &inc=login
        fetchDataFromAPI(urlString: "https://randomuser.me/api/?page=9&results=100&seed=foobar") { result in
            switch result {
            case .success(let data):
                // Decode the fetched data into the Login model
                let decodedResult: Result<Login, Error> = self.decodeData(data: data, into: Login.self)
                // Handle the decoding result
                switch decodedResult {
                case .success(let loginResponse):
                    if let index = loginResponse.results.firstIndex(where: { $0.login.username == username && $0.login.password == password }) {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.view.makeToast("Login Successful", duration: 2.0, position: .bottom)
                            let vc: UserDetailsVC = UserDetailsVC.instantiate(appStoryboard: .user)
                            let name = joinStrings(loginResponse.results[index].name.title, loginResponse.results[index].name.first, loginResponse.results[index].name.last)
                            print(name)
                            vc.userData = UserProfile(image: loginResponse.results[index].picture.large, name: name, email: loginResponse.results[index].email, phoneNumber: loginResponse.results[index].phone)
                            self.navigationController?.pushViewController(vc, animated: true)
                            emptyFields()
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.view.makeToast("Please enter the right credentials", duration: 2.0, position: .bottom)
                        }
                    }

                case .failure(let error):
                    print("Error decoding API response: \(error.localizedDescription)")
                    self.view.makeToast("Error Loading Data", duration: 2.0, position: .bottom)
                }
                
            case .failure(let error):
                print("Error fetching data from API: \(error.localizedDescription)")
                self.view.makeToast("Error Loading Data", duration: 2.0, position: .bottom)
            }
        }
    }
}

extension LoginVC{
    // Your implementation of the isPasswordValid function
    

    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    
}
