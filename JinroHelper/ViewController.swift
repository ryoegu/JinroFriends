//
//  ViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/01/06.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var allDataArr = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        writeDataIfFirst()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func writeDataIfFirst() {
        /* Get ManagedObjectContext from AppDelegate */
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        if numberOfDataFromEntity("RoleData", managedObjectContext: managedContext) == 0{
            /* Create new ManagedObject */
            let entity = NSEntityDescription.entityForName("RoleData", inManagedObjectContext: managedContext)
            /* Set the name attribute using key-value coding */
            let roleStringArray:[String] = ["ゲームマスター","占い師","霊媒師","狩人","恋人","村人","富豪","人狼","狂人","多重人格","妖狐"]
            let teamIntArray:[Int] = [0,1,1,1,1,1,1,2,2,2,3]
            let typeIntArray:[Int] = [1,0,1,1,3,2,5,4,5,5,1]
            let numberIntArray:[Int] = [0,1,1,1,0,1,0,1,0,0,0]
            let validBoolArray:[Bool] = [true,true,true,true,false,true,false,true,false,false,false]
            
            for var i=0;i<=10;i++ {
                //setFirstData
                let personObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                //deleteName(allDataArr[0])
                personObject.setValue(i, forKey: "id")
                personObject.setValue(teamIntArray[i], forKey: "team")
                personObject.setValue(roleStringArray[i], forKey: "role")
                personObject.setValue(numberIntArray[i], forKey: "number")
                personObject.setValue(typeIntArray[i], forKey: "type")
                personObject.setValue(validBoolArray[i], forKey: "valid")

                /* Error handling */
                var error: NSError?
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }
                println("object saved")
            }
            
        }else{
            NSLog("もともとCoreDataにデータがあるので飛ばされた...")
        }
    }
    
    func numberOfDataFromEntity(entityName: String, managedObjectContext: NSManagedObjectContext) -> Int {
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)
        request.includesSubentities = false
        var error: NSError? = nil;
        let count = managedObjectContext.countForFetchRequest(request, error: &error)
        return error == nil ? count : 0
    }

}

