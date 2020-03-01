//
//  IntroViewController.swift
//  IQ69
//
//  Created by HuuNghia on 2/6/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class IntroViewController: UIViewController {
    
    var lstQuestion:[Question] = []

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(backHandle))
        setupButton()
        DataProvider.questionBus.correctAns = 0
        //lstQuestion = DataProvider.questionBus.fetchQuestion()
    }
    
    @objc func backHandle() {
        //alert
        let alert = UIAlertController(title: "Thong bao", message: "Ban muon thoat", preferredStyle: .alert)
        let btnNo = UIAlertAction(title: "No", style: .default, handler: nil)
        let btnYes = UIAlertAction(title: "Yes", style: .cancel) { (btnYes) in
            let vc = UINavigationController(rootViewController: HomeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        alert.addAction(btnNo)
        alert.addAction(btnYes)
        present(alert, animated: true)
    }
    
    func setupButton() {
        playButton.addTarget(self, action: #selector(yoloHandle), for: .touchUpInside)
    }
    
    @objc func yoloHandle() {
        let vc = PlayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
