//
//  LoginViewController.swift
//  IQ69
//
//  Created by HuuNghia on 12/28/19.
//  Copyright © 2019 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginRegisterControl: UISegmentedControl!
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var registerNameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginRegisterButton: UIButton!
    @IBAction func controlHandle(_ sender: Any) {
        if loginRegisterControl.selectedSegmentIndex == 0 {
            loginStackView.isHidden = false
            registerStackView.isHidden = true
            loginRegisterButton.setTitle("Login", for: .normal)
        } else {
            loginStackView.isHidden = true
            registerStackView.isHidden = false
            loginRegisterButton.setTitle("Register", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        setupView()
    }
    
    func setupView() {
        //loginRegisterButton
        loginRegisterButton.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        loginRegisterButton.setTitleColor(.white, for: .normal)
        loginRegisterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginRegisterButton.addTarget(self, action: #selector(buttonHandle), for: .touchUpInside)
        //loginStackView
        loginStackView.isHidden = true
    }
    
    @objc func buttonHandle() {
        switch loginRegisterControl.selectedSegmentIndex {
        case 0:
            loginHandle()
            break
        default:
            registerHandle()
        }
    }
    
    
    func loginHandle() {
        guard let email = loginEmailTextField.text, let password = loginPasswordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func registerHandle() {
        guard let name = registerNameTextField.text, let email = registerEmailTextField.text, let password = registerPasswordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            
            //succesfully authenticated user
            var ref: DatabaseReference!
            ref = Database.database().reference(fromURL: "https://iq69-e9bb0.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            let values = ["name": name,
                          "email": email]
            userRef.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
