//
//  ResultViewController.swift
//  IQ69
//
//  Created by HuuNghia on 1/11/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class ResultViewController: UIViewController {
    
    @IBOutlet weak var correctAnsLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var savePointButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        savePointButton.addTarget(self, action: #selector(savePointHandle), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartHandle), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitHandle), for: .touchUpInside)
        
        pointLabel.text = "\(DataProvider.questionBus.totalPoint())"
        correctAnsLabel.text = "\(DataProvider.questionBus.totalCorrectAns())"
    }
    
    @objc func savePointHandle() {
        DataProvider.questionBus.savePoints()
        // Thong bao
        let alert = UIAlertController(title: "Thông báo", message: "Lưu điểm thành công. Bạn có đẹp trai?", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Có bạn đẹp trai vãi", style: .cancel) { (btnOk) in
            let vc = UINavigationController(rootViewController: IntroViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        let btnNo = UIAlertAction(title: "Không", style: .default) { (btnNo) in
            let vc = UINavigationController(rootViewController: HomeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        alert.addAction(btnOk)
        alert.addAction(btnNo)
        self.present(alert, animated: true)
    }
    
    @objc func restartHandle() {
        let vc = UINavigationController(rootViewController: IntroViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @objc func exitHandle() {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có đẹp trai?", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Có bạn đẹp trai vãi", style: .cancel) { (btnOk) in
            let vc = UINavigationController(rootViewController: IntroViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        let btnNo = UIAlertAction(title: "Không", style: .default) { (btnNo) in
            let vc = UINavigationController(rootViewController: HomeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        alert.addAction(btnOk)
        alert.addAction(btnNo)
        self.present(alert, animated: true)
    }
}
