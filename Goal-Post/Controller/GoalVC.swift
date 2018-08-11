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


    var goal = [Goal]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    @IBOutlet weak var goalMessageView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchGoal { (isSuccess) in
            print("Fetching Success \(self.goal.count)")
            self.tableView.reloadData()
            if (self.goal.count == 0){
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false

            }
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GoalPostCell", for: indexPath) as? GoalCell{
            cell.updateCell(goal: goal[indexPath.row])
            return cell
        }
        return GoalCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goal.count
    }

    private func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    @IBAction func createGoalPost(_ sender: Any) {
        let createGoalVc = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") as! CreateGoalVC
        self.presentVC(viewController: createGoalVc)
    }
}


extension GoalVC {
    
    func fetchGoal(completionHandler : @escaping (_ completion : Bool)->Void) {
        guard let managedContext =  appDelegate?.persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goal = try managedContext.fetch(fetchRequest) as! [Goal]
            completionHandler(true)
        }catch{
            completionHandler(false)
            debugPrint("fetch Request error  \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

