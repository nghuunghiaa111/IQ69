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
        DataProvider.questionBus.checkAns(ans: ans)
        ques = ques + 1
        title = "Câu \(ques)"
        aButton.backgroundColor = .red
        bButton.backgroundColor = .red
        cButton.backgroundColor = .red
        dButton.backgroundColor = .red
        if ques == 10 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(endHandle))
        }
        DataProvider.questionBus.createData(questionPath: ques, question: questionLabel, ans1: aButton, ans2: bButton, ans3: cButton, ans4: dButton)
    }
    
    @objc func endHandle() {
        DataProvider.questionBus.checkAns(ans: ans)
        let resultController = ResultViewController()
        resultController.modalPresentationStyle = .fullScreen
        self.present(resultController, animated: true)
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
    
//    @objc func yoloHandle() {
//        introView.isHidden = true
//        
//        //DataProvider.questionBus.refreshScreen(question: questionLabel, ans1: aButton, ans2: bButton, ans3: cButton, ans4: dButton)
//        DataProvider.questionBus.createData(questionPath: ques, question: questionLabel, ans1: aButton, ans2: bButton, ans3: cButton, ans4: dButton)
//    }
    
}
