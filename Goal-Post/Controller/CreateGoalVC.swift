//
//  CreateGoalVC.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController , UITextViewDelegate {

    @IBOutlet weak var postField : UITextView!
    @IBOutlet weak var longTermBtn : UIButton!
    @IBOutlet weak var shortTermBtn : UIButton!
    @IBOutlet weak var nextBtn : UIButton!

    private var goalStr = ""
    private var goalType : GOALTYPE = .SHORT_TERM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        postField.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postField.text = ""
        postField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    

    @IBAction func createGoalPressed(_ sender: Any) {
        goalStr = postField.text
        guard postField.text != "" , postField.text != "What is your goal?" else {
            return
        }
        let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as! FinishGoalVC
        finishVC.setData(description: goalStr, goalType: goalType)
        presentingViewController? .presentToViewController(vc: finishVC)
    }
   
    @IBAction func backBtnPrssed(_ sender : Any){
        self.dissmissVC()
    }
    
    @IBAction func longTermBtnPressed(_ sender : Any){
        goalType = .LONG_TERM
        shortTermBtn.unSelectedBgColor()
        longTermBtn.selectedBgColor()
    }
    @IBAction func shortTermBtnPressed(_ sender : Any){
        goalType = .SHORT_TERM
        shortTermBtn.selectedBgColor()
        longTermBtn.unSelectedBgColor()
    }
}


