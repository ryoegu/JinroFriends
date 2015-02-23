//
//  RoleNumberSettingViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/22.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class RoleNumberSettingViewController: UIViewController {

    @IBOutlet var teamLabel: MKLabel!
    @IBOutlet var roleLabel: MKLabel!
    @IBOutlet var explainTextView: UITextView!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var roleImageView: UIImageView!
    var number:Int = 0                 //人数
    var roleArray = [[String]]()    //もともとのArray
    var index:Int = 0                  //id番号
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getDataFromCoreData()
        let saveData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        index = saveData.integerForKey("currentIndex")
        number = roleArray[index][3].toInt()!
        changeNumber(number)
        self.showTeam()
        self.showRole()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveDataInCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plus(sender: MKButton) {
        var roleNumber:Int = roleArray[index][3].toInt()!
        switch roleArray[index][4] {
        case "1":
            if roleNumber == 0{
                roleNumber++
            }
        case "2":
            if roleNumber < 20 {
                roleNumber++
            }
            break
        case "3":
            if roleNumber == 0{
                roleNumber = 2
            }
            break
        case "4":
            if roleNumber < 3 {
                roleNumber++
            }
        case "5":
            if roleNumber < 2 {
                roleNumber++
            }
            break
        default:
            break
        }

        self.changeNumber(roleNumber)
    }

    @IBAction func minus(sender: MKButton) {
        var roleNumber:Int = roleArray[index][3].toInt()!
        switch roleArray[index][4] {
        case "1","2","5":
            if roleNumber > 0 {
                roleNumber--
            }
        case "3":
            if roleNumber == 2 {
                roleNumber = 0
            }
            break
        case "4":
            if roleNumber > 1 {
                roleNumber--
            }
            break
        default:
            break
        }
        self.changeNumber(roleNumber)
    }
    
    func changeNumber(roleNumber:Int) {
        roleArray[index][3]=String(roleNumber)
        numberLabel.text = String(roleNumber)
    }
    
    func showTeam(){
        //村人と人狼にわける
        switch roleArray[index][1] {
        case "1"://村人陣営
            roleImageView.image = UIImage(named: "村人150s.png")
            teamLabel.text = "村人陣営"
        case "2"://人狼陣営
            roleImageView.image = UIImage(named: "人狼150s.png")
            teamLabel.text = "人狼陣営"
        default://第3勢力
            roleImageView.image = UIImage(named: "第3勢力150s.png")
            teamLabel.text = "第3勢力"
        }
    }
    
    func showRole() {
        roleLabel.text = roleArray[index][2]
        //explainTextView.text = explainArray[index]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Core Data
    func getDataFromCoreData() {
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
    
    func saveDataInCoreData() {
        // AppDelegateクラスのインスタンスを取得
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // AppDelegateクラスからNSManagedObjectContextを取得
        // ゲッターはプロジェクト作成時に自動生成されている
        if let managedObjectContext = appDelegate.managedObjectContext {
            // EntityDescriptionのインスタンスを生成
            let entityDiscription = NSEntityDescription.entityForName("RoleData", inManagedObjectContext: managedObjectContext);
            // NSFetchRequest SQLのSelect文のようなイメージ
            let fetchRequest = NSFetchRequest();
            fetchRequest.entity = entityDiscription;
            // NSPredicate SQLのWhere句のようなイメージ
            for var i = 0; i<=10; i++ {
                let predicate = NSPredicate(format: "%K = %d", "id", i)
                fetchRequest.predicate = predicate
                //
                var error: NSError? = nil;
                // フェッチリクエストの実行
                if var results = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) {
                    for managedObject in results {
                        let model = managedObject as RoleData;
                        model.id = roleArray[i][0].toInt()!
                        model.team = roleArray[i][1].toInt()!
                        model.role = roleArray[i][2]
                        model.number = roleArray[i][3].toInt()!
                        model.type = roleArray[i][4].toInt()!
                    }
                    
                }
            }
            // AppDelegateクラスに自動生成された saveContext で保存完了
            appDelegate.saveContext()
        }
    }
}
