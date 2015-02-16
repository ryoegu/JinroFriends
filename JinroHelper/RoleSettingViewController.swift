//
//  RoleSettingViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/15.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit
import CoreData

class RoleSettingViewController: UIViewController,OTPageScrollViewDataSource,OTPageScrollViewDelegate {
    @IBOutlet var teamLabel: MKLabel!
    @IBOutlet var roleLabel: MKLabel!
    
    @IBOutlet var currentNumberLabel: UILabel!
    // ステータスバーの高さを取得
    let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    // ナビゲーションバーの高さを取得
    var navBarHeight:CGFloat!
    
    var roleArray = [[String]]()
    
    //現在選択されているindexを取得
    var currentIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarHeight = self.navigationController?.navigationBar.bounds.size.height
        let saveData = NSUserDefaults.standardUserDefaults()
        let paddingTop = navBarHeight + statusBarHeight
        saveData.setObject(Float(paddingTop), forKey: "PADDING")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCoreData()
        makeRoleScrollView()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: OTPageScrollView & ScrollView Methods
    func makeRoleScrollView() {
        let roleSelectView:OTPageView = OTPageView(frame: CGRectMake(0, statusBarHeight+navBarHeight, self.view.bounds.size.width, 150))
        roleSelectView.pageScrollView.dataSource = self
        roleSelectView.pageScrollView.delegate = self
        roleSelectView.pageScrollView.padding = 0
        roleSelectView.pageScrollView.leftRightOffset = Float(self.view.bounds.size.width/2-50)
        //self.frame.size.width - _cellSize.width)/2
        roleSelectView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(roleSelectView)
        
        roleSelectView.pageScrollView.reloadData()
        
    }
    func pageScrollView(pageScrollView: OTPageScrollView!, viewForRowAtIndex index: Int32) -> UIView! {
        let cellView:UIView = UIView(frame: CGRectMake(0,0, 100, 100))
        let indexPath = Int(index)
        var colorOfCell:UIColor!
        
        switch roleArray[indexPath][1] {
        case "1": //村人：緑を基調
            colorOfCell = RGBA(R: 50, G: 205, B: 50, A: 1.0)
        case "2": //人狼：赤を基調
            colorOfCell = RGBA(R: 220, G: 20, B: 60, A: 1.0)
        case "3": //第3勢力：紫を基調
            colorOfCell = RGBA(R: 139, G: 0, B: 139, A: 1.0)
        default: //その他：なし
            colorOfCell = RGBA(R: 0, G: 0, B: 0, A: 1.0)
            
        }
        cellView.backgroundColor = colorOfCell
        cellView.layer.cornerRadius = 50
        let roleLabel:UILabel = UILabel(frame: CGRectMake(5, 5, 90, 90))
        roleLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        roleLabel.font = UIFont(name:"HiraMinProN-W3",size:20)
        roleLabel.textColor = UIColor.blackColor()
        roleLabel.layer.cornerRadius = 45
        roleLabel.clipsToBounds = true
        roleLabel.adjustsFontSizeToFitWidth = true
        roleLabel.textAlignment = NSTextAlignment.Center
        roleLabel.text = roleArray[indexPath][2]
        
        cellView.addSubview(roleLabel)
        
        return cellView
    }
    
    
    func numberOfPageInPageScrollView(pageScrollView: OTPageScrollView!) -> Int {
        return roleArray.count
    }
    func sizeCellForPageScrollView(pageScrollView: OTPageScrollView!) -> CGSize {
        return CGSizeMake(100, 100)
    }
    func pageScrollView(pageScrollView: OTPageScrollView!, didTapPageAtIndex index: Int) {
        NSLog("click cell at %d", index)
        currentIndex = index
        
        //村人と人狼にわける
        switch roleArray[index][1] {
        case "1":
            teamLabel.text = "村人陣営"
            teamLabel.textColor = RGBA(R: 50, G: 205, B: 50, A: 1.0)
            roleLabel.textColor = RGBA(R: 50, G: 205, B: 50, A: 1.0)
            
        case "2":
            teamLabel.text = "人狼陣営"
            teamLabel.textColor = RGBA(R: 220, G: 20, B: 60, A: 1.0)
            roleLabel.textColor = RGBA(R: 220, G: 20, B: 60, A: 1.0)
        default:
            teamLabel.text = "第3勢力"
            teamLabel.textColor = RGBA(R: 139, G: 0, B: 139, A: 1.0)
            roleLabel.textColor = RGBA(R: 139, G: 0, B: 139, A: 1.0)
        }
        roleLabel.text = roleArray[index][2]
        currentNumberLabel.text = roleArray[index][3]
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let point = CGPointMake(scrollView.contentOffset.x, 0)
        scrollView.contentOffset = point
    }
    
    // MARK: Button(change number) Methods
    @IBAction func plus() {
        var roleNumber = roleArray[currentIndex][3].toInt()!
        
        switch roleArray[currentIndex][4] {
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
        changeNumber(roleNumber)
        
    }
    
    @IBAction func minus() {
        var roleNumber = roleArray[currentIndex][3].toInt()!
        switch roleArray[currentIndex][4] {
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
        changeNumber(roleNumber)
    }
    
    func changeNumber(roleNumber:Int ) {
        roleArray[currentIndex][3]=String(roleNumber)
        currentNumberLabel.text = String(roleNumber)
    }
    
    @IBAction func start() {
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
