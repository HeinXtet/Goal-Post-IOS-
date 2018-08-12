//
//  CoreDataService.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/12/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    let appdelegate = UIApplication.shared.delegate as? AppDelegate
    static let instance = CoreDataService()
    var goal = [Goal]()    
    
    func fetchGoals(completion : @escaping (_ completion : Bool)->Void) {
        self.goal.removeAll()
        guard  let managedContext = appdelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do{
            goal = try managedContext.fetch(fetchRequest) as! [Goal]
            completion(true)
            print("goal \(goal.count)")
        }catch{
            completion(false)
            debugPrint("fetch goals error \(error.localizedDescription)")
        }
    }
    
    func setProgress( index :Int,  completion : @escaping (_ completion : Bool)-> Void) {
        guard  let managedContext = appdelegate?.persistentContainer.viewContext else {return}
        let manageGoal = goal[index]
        if manageGoal.goalTatalProgress > manageGoal.goalProgress {
            manageGoal.goalProgress = manageGoal.goalProgress + 1
        }else{
            return
        }
        do{
            try managedContext.save()
            completion(true)
            debugPrint("setprogress success")
        }catch{
            debugPrint("progress set error \(error.localizedDescription)")
        }
    }
    
    func removeData(index : Goal , completionHander : @escaping (_ completion : Bool)->Void) {
        guard  let managedContext = appdelegate?.persistentContainer.viewContext else {return}
        
        print("count \(managedContext.insertedObjects.count)" )
        managedContext.delete(index)
            do {
                try managedContext.save()
            }catch{
                debugPrint("error remove \(error.localizedDescription)")
            }
        completionHander(true)
    }
    
    
    func addData(description : String, type : String, totalProgress : Int32,compleHander : @escaping (_ completion : Bool)->Void) {
        guard  let managedContext = appdelegate?.persistentContainer.viewContext else {return}
        do{
            let goal = Goal(context: managedContext)
            goal.goalType = type
            goal.goalDescription  = description
            goal.goalTatalProgress = totalProgress
            goal.goalProgress = 0
            try managedContext.save()
            compleHander(true)
        }catch{
            compleHander(false)
            debugPrint("fetch goals error \(error.localizedDescription)")
        }
    }
}
