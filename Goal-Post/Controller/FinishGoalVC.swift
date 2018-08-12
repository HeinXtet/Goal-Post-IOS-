//
//  FinishGoalVC.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit


class FinishGoalVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    
    @IBOutlet weak var goalPointField: UITextField!
    private var goalType = ""
   private var goalDescription  = ""
    @IBOutlet weak var createBtn: UIButton!
    @IBAction func createFinishGoalPressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createBtn.bindToKeyboard()
    }

    func setData(description : String, goalType : GOALTYPE){
        self.goalType = goalType.rawValue
        self.goalDescription = description
        print("goal type \(goalType) description \(description)")
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dissmissVC()
    }
    
    @IBAction func finishGoalVC(_ sender: Any) {
        self.addGoal { (isSuccess) in
            self.dissmissVC()
        }
    }
}

extension FinishGoalVC {
    func addGoal(compleHandler : @escaping (_ compltion: Bool)->Void) {
        guard let managedObject = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedObject)
        goal.goalDescription = goalDescription
        goal.goalTatalProgress = Int32(goalPointField.text!)!
        goal.goalProgress  = Int32(0)
        goal.goalType = goalType
        do{
           try managedObject.save()
            debugPrint("success save ")
            compleHandler(true)
        }catch{
            compleHandler(false)
            debugPrint("add data error \(error.localizedDescription)")
        }
    }
    

}
