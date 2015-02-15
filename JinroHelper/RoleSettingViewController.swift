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
    //@IBOutlet var roleSelectView: OTPageView!
    var roleArray = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
        /*
UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-2, 260, 4, 10)];
arrowView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
[self.view addSubview:arrowView];
*/

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
        let roleSelectView:OTPageView = OTPageView(frame: CGRectMake(0, self.view.bounds.size.height-150, self.view.bounds.size.width, 150))
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
        let cell:UIView = UIView(frame: CGRectMake(0,0, 100, 100))
        cell.backgroundColor = UIColor.blackColor()
        //cell.layer.cornerRadius = 50
        let roleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, 100, 100))
        roleLabel.backgroundColor = UIColor.whiteColor()
        roleLabel.textColor = UIColor.blackColor()
        roleLabel.layer.cornerRadius = 50
        roleLabel.clipsToBounds = true
        //roleLabel.sizeToFit()
        roleLabel.adjustsFontSizeToFitWidth = true
        roleLabel.textAlignment = NSTextAlignment.Center
        
        let indexPath = Int(index)
        roleLabel.text = roleArray[indexPath][2]
        
        cell.addSubview(roleLabel)
        return cell
    }
    
    func numberOfPageInPageScrollView(pageScrollView: OTPageScrollView!) -> Int {
        return roleArray.count
    }
    func sizeCellForPageScrollView(pageScrollView: OTPageScrollView!) -> CGSize {
        return CGSizeMake(100, 100)
    }
    func pageScrollView(pageScrollView: OTPageScrollView!, didTapPageAtIndex index: Int) {
        NSLog("click cell at %d", index)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let point = CGPointMake(scrollView.contentOffset.x, 0)
        scrollView.contentOffset = point
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
