//
//  RoleSettingViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/15.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class RoleSettingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet var currentNumberLabel: UILabel!
    // ステータスバーの高さを取得
    let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    // ナビゲーションバーの高さを取得
    var navBarHeight:CGFloat!
    var roleArray = [[String]]()
    @IBOutlet var roleCollectionView: UICollectionView!
    //現在選択されているindexを取得
    var currentIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarHeight = self.navigationController?.navigationBar.bounds.size.height
        let saveData = NSUserDefaults.standardUserDefaults()
        let paddingTop = navBarHeight + statusBarHeight
        saveData.setObject(Float(paddingTop), forKey: "PADDING")
        roleCollectionView.delegate = self
        roleCollectionView.dataSource = self
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCoreData()
        roleCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as RoleSettingCollectionViewCell
        cell.roleLabel!.text = roleArray[indexPath.row][2]
        cell.numberLabel!.text = roleArray[indexPath.row][3]
        switch roleArray[indexPath.row][1] {
            case "1":
            cell.roleLabel!.backgroundColor = RGBA(R: 102, G: 184, B: 115, A: 1.0)
            case "2":
            cell.roleLabel!.backgroundColor = RGBA(R: 230, G: 60, B: 53, A: 1.0)
        default:
            cell.roleLabel!.backgroundColor = RGBA(R: 88, G: 68, B: 109, A: 1.0)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roleArray.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let saveData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        saveData.setInteger(indexPath.row, forKey: "currentIndex")
        println(indexPath.row)
        performSegueWithIdentifier("toDetail", sender: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: START Button Method
       @IBAction func start() {
        performSegueWithIdentifier("toAssignView",sender: nil)

    }
    
    
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
    
    // MARK: exchange RGBA Method
    func RGBA(#R:Int, G:Int, B:Int, A:CGFloat) -> UIColor{
        let r = CGFloat(R)/255.0
        let g = CGFloat(G)/255.0
        let b = CGFloat(B)/255.0
        return UIColor(red: r, green: g, blue: b, alpha: A)
    }
    
    
}
