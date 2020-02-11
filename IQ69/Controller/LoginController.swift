//
//  LoginController.swift
//  IQ69
//
//  Created by HuuNghia on 12/28/19.
//  Copyright © 2019 HuuNghia. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var registerLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        registerLoginButton.setTitleColor(.white, for: .normal)
        registerLoginButton.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        registerLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerLoginButton.addTarget(self, action: #selector(buttonHandle), for: .touchUpInside)
    }
    
    @objc func buttonHandle() {
        
    }
}
