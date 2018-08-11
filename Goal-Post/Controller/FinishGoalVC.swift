//
//  FinishGoalVC.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

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
        self.dismiss(animated: true, completion: nild)
        
    }
    
    @IBAction func finishGoalVC(_ sender: Any) {
    }
}
