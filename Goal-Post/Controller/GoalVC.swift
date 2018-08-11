//
//  ViewController.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import CoreData

class GoalVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var goalMessageView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GoalPostCell", for: indexPath) as? GoalCell{
            return cell
        }
        return GoalCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    private func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    @IBAction func createGoalPost(_ sender: Any) {
        
    }
}

