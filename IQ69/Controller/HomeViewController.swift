//
//  HomeViewController.swift
//  IQ69
//
//  Created by HuuNghia on 12/28/19.
//  Copyright © 2019 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //updateQuestion()
        // Do any additional setup after loading the view.
        title = "IQ69"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButtonHandle))
        
        //setupView
        setupView()
        
        //user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(logoutButtonHandle), with: nil, afterDelay: 0)
        }
    }
    
    @objc func logoutButtonHandle() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func setupView() {
        //button
        playButton.layer.cornerRadius = 15
        highScoreButton.layer.cornerRadius = 15
        exitButton.layer.cornerRadius = 15
        //target
        playButton.addTarget(self, action: #selector(playHandle), for: .touchUpInside)
        highScoreButton.addTarget(self, action: #selector(hsHandle), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitHandle), for: .touchUpInside)
    }
    
    @objc func playHandle() {
        let vc = UINavigationController(rootViewController: IntroViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func hsHandle() {
        let vc = UINavigationController(rootViewController: HighScoreViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func exitHandle() {
        let alert = UIAlertController(title: "Thong bao", message: "Ban co dep trai?", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Co dep trai vai", style: .cancel, handler: nil)
        let btnNo = UIAlertAction(title: "Khong", style: .default) { (btnNo) in
            exit(0)
        }
        alert.addAction(btnOk)
        alert.addAction(btnNo)
        self.present(alert, animated: true)
    }
    
    func updateQuestion() {
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://iq69-e9bb0.firebaseio.com/")
        let questionRef = ref.child("questions").child("question10")
        let value = ["question":"Cái gì người mua biết, người bán biết, người xài không bao giờ biết?",
                     "ans1":"Áo",
                     "ans2":"Đồ chơi",
                     "ans3":"Điện thoại",
                     "ans4":"Quan tài",
                     "correctAns":"Quan tài"]
        questionRef.updateChildValues(value)
    }
}
