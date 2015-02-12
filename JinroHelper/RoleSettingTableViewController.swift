//
//  RoleSettingTableViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/06.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class RoleSettingTableViewController: UITableViewController {
    @IBOutlet var roleTableView: UITableView!
    var roleArray = [[String]]()
    var lastScrollOffset:CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //roleArray = savedata.objectForKey("roleInfo") as? [String]
        tableView.allowsSelection = false
        
        let xib = UINib(nibName: "RoleSettingTableViewCell", bundle: nil)
        roleTableView.registerNib(xib,forCellReuseIdentifier:"Cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.backgroundColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        
        // テーブル情報を更新する
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return roleArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as RoleSettingTableViewCell
        
        cell.roleLabel!.text = roleArray[indexPath.row][2]
        cell.roleNumberLabel!.text = roleArray[indexPath.row][3]
        cell.plusButton.addTarget(self, action: "plusMethod:event:", forControlEvents: .TouchUpInside)
        cell.minusButton.addTarget(self, action: "minusMethod:event:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    func plusMethod(sender:UIButton, event:UIEvent){
        let touch:UITouch = event.allTouches()?.anyObject() as UITouch
        let point:CGPoint = touch.locationInView(roleTableView)
        let indexPath:NSIndexPath = roleTableView.indexPathForRowAtPoint(point)!
        var roleNumber = roleArray[indexPath.row][3].toInt()!
        
        switch roleArray[indexPath.row][4] {
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
        
        roleArray[indexPath.row][3]=String(roleNumber)
        NSLog("%@",roleArray)
        tableView.reloadData()
        
    }
    func minusMethod(sender:UIButton, event:UIEvent){
        let touch:UITouch = event.allTouches()?.anyObject() as UITouch
        let point:CGPoint = touch.locationInView(roleTableView)
        let indexPath:NSIndexPath = roleTableView.indexPathForRowAtPoint(point)!
        var roleNumber = roleArray[indexPath.row][3].toInt()!
        
        
        switch roleArray[indexPath.row][4] {
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
        
        roleArray[indexPath.row][3]=String(roleNumber)
        NSLog("%@",roleArray)
        tableView.reloadData()
    }
    @IBAction func startButton(sender: UIBarButtonItem) {
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
        performSegueWithIdentifier("toAssignView",sender: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */



}
