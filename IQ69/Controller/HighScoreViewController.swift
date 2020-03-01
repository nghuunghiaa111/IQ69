//
//  HighScoreViewController.swift
//  IQ69
//
//  Created by HuuNghia on 2/7/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import UIKit
import Firebase

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hsTableView: UITableView!
    
    var lstUser:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "High Score"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeHandle))
        setupTabelView()
        createData()
    }
    
    @objc func closeHandle() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupTabelView() {
        hsTableView.dataSource = self
        hsTableView.delegate = self
    }
    
    func createData() {
        var ref:DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").observe(.value) { (snapshot) in
            if self.lstUser.count > 0 {
                self.lstUser.removeAll()
            }
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let dict = child.value as! [String: AnyObject]
                let user = User()
                user.name = dict["name"] as? String
                user.email = dict["email"] as? String
                user.points = dict["point"] as? String
                
                self.lstUser.append(user)
                
            }
            self.lstUser.sort {
                self.stringToInt(point: $0.points ?? "0") > self.stringToInt(point: $1.points ?? "0")
            }
            self.hsTableView.reloadData()
        }
    }
    
    func stringToInt(point: String) -> Int {
        var pointInt = 0
        pointInt = Int(point) ?? 0
        return pointInt
    }
    
    //tableView protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let user = lstUser[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = (user.points ?? "0") + " points"
        return cell
    }

}
