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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var undoView: UIView!
    @IBOutlet weak var goalMessageView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    private var tempIndexPath : IndexPath?
    private var tempGoal : Goal?
    private var undoExits = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func removeTempGoal(){
        if (self.undoExits){
            CoreDataService.instance.removeData(index : tempGoal!, completionHander: { (isSuccess) in
                if (isSuccess){
                    self.fetchCoreGoal()
                    self.undoExits = false
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreGoal()
    }

    @IBAction func undoPressed(_ sender: Any) {
        undoExits = false
        CoreDataService.instance.goal.insert(tempGoal!, at: tempIndexPath!.row)
        self.tableView.insertRows(at: [tempIndexPath!], with: .automatic)
        self.undoView.isHidden = true
        self.undoExits = false

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GoalPostCell", for: indexPath) as? GoalCell{
            cell.updateCell(goal: CoreDataService.instance.goal[indexPath.row])
            return cell
        }
        return GoalCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataService.instance.goal.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if undoExits {
            removeTempGoal()
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "DELETE") { action, index in
           self.undoView.isHidden = false
            self.tempIndexPath = indexPath
            print("delete index \(self.tempIndexPath!.row)")
            self.undoExits = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.undoView.isHidden = true
                self.removeTempGoal()
            }
            self.tempGoal = CoreDataService.instance.goal[indexPath.row]
            CoreDataService.instance.goal.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        delete.backgroundColor = UIColor.red
        let addProgress = UITableViewRowAction(style: .normal, title: "ADD") { (action, index) in
            CoreDataService.instance.setProgress(index: indexPath.row, completion: { (isSuccess) in
                if isSuccess{
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            })
        }
        addProgress.backgroundColor = UIColor.orange
        return [delete,addProgress]
    }
    
    
    private func fetchCoreGoal(){
        CoreDataService.instance.fetchGoals { (isSuccess) in
            if (isSuccess){
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("fetch success \(CoreDataService.instance.goal.count)")
                if (CoreDataService.instance.goal.count == 0){
                    self.tableView.isHidden = true
                }else{
                    self.tableView.isHidden = false
                    
                }
            }
            
        }
    }


    private func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        self.undoView.isHidden = true
    }
    
    @IBAction func createGoalPost(_ sender: Any) {
        let createGoalVc = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") as! CreateGoalVC
        self.presentVC(viewController: createGoalVc)
    }
}


