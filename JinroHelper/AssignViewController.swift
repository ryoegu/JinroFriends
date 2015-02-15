//
//  AssignViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/12.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class AssignViewController: UIViewController {

    @IBOutlet var explainLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var assignButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    var roleArray = [[String]]()
    //var assignDictionary:[NSDictionary] = [String,String]()
    var wholeNumber:Int = 0
    var assignInfoArray = [AnyObject]()
    var currentNumber:Int = 0
    var shuffledAssignedArray = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadDataFromCoreData()
        NSLog("%@",roleArray)
        var assignDictionary = ["id":"1"]
        
        for var i = 0; i < roleArray.count; i++ {
            wholeNumber = wholeNumber + roleArray[i][3].toInt()!
        }
        
        for var i=0; i<roleArray.count; i++ {
            if roleArray[i][3].toInt()>1 {
                for var j=1;j<=roleArray[i][3].toInt();j++ {
                    assignDictionary["id"]=roleArray[i][0]
                    assignDictionary["team"]=roleArray[i][1]
                    assignDictionary["role"]=roleArray[i][2] + String(j)
                    assignDictionary["screenRole"]=roleArray[i][2]
                    assignDictionary["living"]="true"
                    assignInfoArray.append(assignDictionary)
                }
            }else if roleArray[i][3].toInt()==1{
                assignDictionary["id"]=roleArray[i][0]
                assignDictionary["team"]=roleArray[i][1]
                assignDictionary["role"]=roleArray[i][2]
                assignDictionary["screenRole"]=roleArray[i][2]
                assignDictionary["living"]="true"
                assignInfoArray.append(assignDictionary)
            }
        }
        shuffledAssignedArray = shuffle(assignInfoArray)
        println(shuffledAssignedArray)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func assignButtonTapped(sender: UIButton) {
        //カードボタンの処理を書く
        let currentDictionary:AnyObject = shuffledAssignedArray[currentNumber]
        println(currentDictionary["screenRole"])
        let roleString = currentDictionary["screenRole"] as? String
        sender.setTitle(roleString, forState: UIControlState.Normal)
        
        nameTextField.enabled = false
        //プレーヤー名をDictionaryに書き込む
        if nameTextField.text == "" {
            nameTextField.text = "Player" + String(currentNumber)
        }
        
        var assignDictionary = ["player":"1"]
        assignDictionary = currentDictionary as Dictionary
        assignDictionary["player"] = nameTextField.text
        shuffledAssignedArray[currentNumber] = assignDictionary
        println(shuffledAssignedArray[currentNumber])
        
        currentNumber += 1
    }

    @IBAction func nextButtonTapped(sender: UIButton) {
        nameTextField.enabled = true
        assignButton.setTitle("カードを引く", forState: UIControlState.Normal)
        nameTextField.text=""
        
        
        if currentNumber == wholeNumber-1 {
            sender.setTitle("次へ", forState: UIControlState.Normal)
        }
        
        if currentNumber == wholeNumber {
           
            self.performSegueWithIdentifier("toGameView", sender: nil)

            
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Core Data Methods
    func loadDataFromCoreData(){
        //配列を初期化
        roleArray = []
        // CoreDataからデータを読み込んで配列memosに格納する
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request: NSFetchRequest = NSFetchRequest(entityName: "RoleData")
        // 並び順をdateの、昇順としてみる
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil) as [RoleData]!
        for data in results {
            let id = data.id            //ID
            let team = data.team        //team（ゲームマスター：0, 村人陣営：1, 人狼陣営:2, 第三勢力：3）
            let role:String = data.role         //役職名
            let number:NSNumber = data.number   //人数
            let type = data.type                //A,B,Cのタイプ
            let valid = data.valid              //有効かどうか
            
            //if valid.boolValue {
            roleArray.append([
                String(id.intValue),
                String(team.intValue),
                role,
                String(number.intValue),
                String(type.intValue)
                ])
            //}
        }
    }
    
    // MARK: - Array Shuffle
    // 参考：http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let count = countElements(list)
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}
