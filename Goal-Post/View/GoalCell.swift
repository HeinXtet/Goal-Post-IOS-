//
//  GoalCell.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalLable : UILabel!
    @IBOutlet weak var goalType : UILabel!
    @IBOutlet weak var goalProgress : UILabel!
    
    @IBOutlet weak var goalCompletionView: UIView!
    let str = "t sounds like what you are looking for is dynamic cell height, there are a few things that need to happen for that to work:t sounds like what you are looking for is dynamic cell height, there are a few things that need to happen for that to work:t sounds like what you are looking for is dynamic cell height, there are a few things that need to happen for that to work:"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func updateCell(goal : Goal) {
        self.goalLable.text = goal.goalDescription
        self.goalProgress.text = String(goal.goalProgress)
        self.goalType.text = goal.goalType
        
        if (goal.goalTatalProgress == goal.goalProgress){
            goalCompletionView.isHidden = false
        }else{
            goalCompletionView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
