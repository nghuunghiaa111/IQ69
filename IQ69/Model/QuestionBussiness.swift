//
//  QuestionBussiness.swift
//  IQ69
//
//  Created by HuuNghia on 2/6/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import UIKit
import Foundation
import Firebase

public class QuestionBussiness {
    private var lstQuestion:[Question] = []
    private var answer = String()
    public var correctAns = 0
    
    public func createData(questionPath: Int, question: UILabel, ans1: UIButton, ans2: UIButton, ans3: UIButton, ans4: UIButton) {
        var ref:DatabaseReference!
        ref = Database.database().reference()
        ref.child("questions").child("question\(questionPath)").observe(.value, with: { (snapshot) in
            
            let dict = snapshot.value as! [String: Any]
            question.text = dict["question"] as? String
            ans1.setTitle(dict["ans1"] as? String, for: .normal)
            ans2.setTitle(dict["ans2"] as? String, for: .normal)
            ans3.setTitle(dict["ans3"] as? String, for: .normal)
            ans4.setTitle(dict["ans4"] as? String, for: .normal)
            self.answer = dict["correctAns"] as! String
        }, withCancel: nil)
    }
    
    public func checkAns(ans: String) {
        if ans == answer {
            correctAns = correctAns + 1
        }
    }
    
    public func savePoints() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://iq69-e9bb0.firebaseio.com/")
        let userChild = ref.child("users").child(uid)
        let text = String(correctAns*10)
        let value = ["point":text]
        userChild.updateChildValues(value as [AnyHashable : Any]) { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
        }
    }
    
    public func totalPoint() -> Int {
        return correctAns * 10
    }
    
    public func totalCorrectAns() -> Int {
        return correctAns
    }
    
}
