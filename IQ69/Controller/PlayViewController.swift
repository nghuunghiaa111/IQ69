//
//  PlayViewController.swift
//  IQ69
//
//  Created by HuuNghia on 12/28/19.
//  Copyright © 2019 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class PlayViewController: UIViewController {
    
    var lstQuestion = [Question]()
    var ques = 1
    var ans = String()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    //@IBOutlet weak var yoloButton: UIButton!
    //@IBOutlet weak var introView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DataProvider.questionBus.createData(questionPath: ques, question: questionLabel, ans1: aButton, ans2: bButton, ans3: cButton, ans4: dButton)
        title = "Câu \(ques)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextHandle))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(backHandle))
        
        //yoloButton.addTarget(self, action: #selector(yoloHandle), for: .touchUpInside)
        aButton.addTarget(self, action: #selector(aButtonHandle), for: .touchUpInside)
        bButton.addTarget(self, action: #selector(bButtonHandle), for: .touchUpInside)
        cButton.addTarget(self, action: #selector(cButtonHandle), for: .touchUpInside)
        dButton.addTarget(self, action: #selector(dButtonHandle), for: .touchUpInside)
        
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
    
    @objc func nextHandle() {
        confirm()
    }
    
    @objc func endHandle() {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn chứ?", preferredStyle: .alert)
        let noBtn = UIAlertAction(title: "Không", style: .cancel, handler: nil)
        let yesBtn = UIAlertAction(title: "Chắc chắn", style: .default) { (yesBtn) in
            DataProvider.questionBus.checkAns(ans: self.ans)
            let resultController = ResultViewController()
            resultController.modalPresentationStyle = .fullScreen
            self.present(resultController, animated: true)
        }
        alert.addAction(noBtn)
        alert.addAction(yesBtn)
        present(alert, animated: true)
    }
    
    @objc func aButtonHandle() {
        checkAnswer(answer: aButton)
    }
    
    @objc func bButtonHandle() {
        checkAnswer(answer: bButton)
    }
    
    @objc func cButtonHandle() {
        checkAnswer(answer: cButton)
    }
    
    @objc func dButtonHandle() {
        checkAnswer(answer: dButton)
    }
    
    func checkAnswer(answer: UIButton) {
        switch answer {
        case aButton:
            if aButton.backgroundColor == .brown {
                aButton.backgroundColor = .red
            } else {
                aButton.backgroundColor = .brown
                if let text = aButton.titleLabel?.text {
                    ans = text
                }
            }
            bButton.backgroundColor = .red
            cButton.backgroundColor = .red
            dButton.backgroundColor = .red
            break
        case bButton:
            if bButton.backgroundColor == .brown {
                bButton.backgroundColor = .red
            } else {
                bButton.backgroundColor = .brown
                if let text = bButton.titleLabel?.text {
                    ans = text
                }
            }
            aButton.backgroundColor = .red
            cButton.backgroundColor = .red
            dButton.backgroundColor = .red
            break
        case cButton:
            if cButton.backgroundColor == .brown {
                cButton.backgroundColor = .red
            } else {
                cButton.backgroundColor = .brown
                if let text = cButton.titleLabel?.text {
                    ans = text
                }
            }
            aButton.backgroundColor = .red
            bButton.backgroundColor = .red
            dButton.backgroundColor = .red
            break
        default:
            if dButton.backgroundColor == .brown {
                dButton.backgroundColor = .red
            } else {
                dButton.backgroundColor = .brown
                if let text = dButton.titleLabel?.text {
                    ans = text
                }
            }
            aButton.backgroundColor = .red
            bButton.backgroundColor = .red
            cButton.backgroundColor = .red
        }
    }
    
    func confirm() {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn chứ?", preferredStyle: .alert)
        let noBtn = UIAlertAction(title: "Không", style: .cancel, handler: nil)
        let yesBtn = UIAlertAction(title: "Chắc chắn", style: .default) { (yesBtn) in
            DataProvider.questionBus.checkAns(ans: self.ans)
            self.ques = self.ques + 1
            self.title = "Câu \(self.ques)"
            self.aButton.backgroundColor = .red
            self.bButton.backgroundColor = .red
            self.cButton.backgroundColor = .red
            self.dButton.backgroundColor = .red
            if self.ques == 10 {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(self.endHandle))
            }
            DataProvider.questionBus.createData(questionPath: self.ques, question: self.questionLabel, ans1: self.aButton, ans2: self.bButton, ans3: self.cButton, ans4: self.dButton)
        }
        alert.addAction(noBtn)
        alert.addAction(yesBtn)
        present(alert, animated: true)
    }

}
