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
    //let mainSize: CGSize = UIScreen.mainScreen().bounds.size
    @IBOutlet var onePlayButton: MKButton!
    @IBOutlet var makeVillageButton: MKButton!
    @IBOutlet var goToVillageButton: MKButton!
    @IBOutlet var settingButton: MKButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onePlayButton.alpha = 0.0
        makeVillageButton.alpha = 0.0
        goToVillageButton.alpha = 0.0
        settingButton.alpha = 0.0
        
        showTitle()
        writeDataIfFirst()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTitle() {
        let titleLabel: UILabel = UILabel(frame: CGRectMake(0,0,400,100))
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/2-100)
        titleLabel.text = "JINROUZU"
        titleLabel.font = UIFont(name:"Journal",size:60)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)

        
        
        UIView.animateWithDuration(2.0,
            animations: {() -> Void in
                titleLabel.center = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/2-200)
                self.showButton()
                
                
            }, completion: {(Bool) -> Void in
        })
        
    }
    
    
    func showButton() {
        UIView.animateWithDuration(
            1.0,
            delay: 1.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.onePlayButton.alpha = 1.0
                self.makeVillageButton.alpha = 1.0
                self.goToVillageButton.alpha = 1.0
                self.settingButton.alpha = 1.0
                
                },
            completion:{
                (value: Bool) in
            }
        )
    }
    
    func writeDataIfFirst() {
        /* Get ManagedObjectContext from AppDelegate */
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        if numberOfDataFromEntity("RoleData", managedObjectContext: managedContext) == 0{
            /* Create new ManagedObject */
            let entity = NSEntityDescription.entityForName("RoleData", inManagedObjectContext: managedContext)
            /* Set the name attribute using key-value coding */
            let roleStringArray:[String] = ["占い師","霊媒師","狩人","恋人","村人","富豪","人狼","狂人","多重人格","妖狐"]
            let teamIntArray:[Int] = [1,1,1,1,1,1,2,2,2,3]
            let typeIntArray:[Int] = [0,1,1,3,2,5,4,5,5,1]
            let numberIntArray:[Int] = [1,1,1,0,1,0,1,0,0,0]
            let validBoolArray:[Bool] = [true,true,true,false,true,false,true,false,false,false]
            
            for var i=0;i<=9;i++ {
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

