//
//  GameViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/15.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var wholeArray = [AnyObject]()
    var cellCount:Int!
    var saveData = NSUserDefaults.standardUserDefaults()
    
    //var manager: BackgroundMusicManager?        // 再生管理クラス
    
    @IBOutlet var seatsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*// 再生管理クラス生成
        manager = BackgroundMusicManager()
        // 管理クラスに再生／一時停止を伝達
        manager!.playOrPause()*/
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getWholeArrayFromUD()
        self.makeTableView()
    }
    func getWholeArrayFromUD(){
        wholeArray = []
        wholeArray = saveData.objectForKey("ASSIGNED") as! Array
        println(wholeArray)
        cellCount = wholeArray.count
    }
    
    func makeTableView() {
        seatsTableView.delegate = self
        seatsTableView.dataSource = self
        seatsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        seatsTableView.opaque=false
        seatsTableView.showsHorizontalScrollIndicator=false
        seatsTableView.showsVerticalScrollIndicator=true
        seatsTableView.registerNib(UINib(nibName: "SeatsTableViewCell", bundle: nil), forCellReuseIdentifier: "SeatsCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SeatsCell", forIndexPath: indexPath) as! SeatsTableViewCell
        var wholeArrayWithIndexPath: (AnyObject) = wholeArray[indexPath.row]
        NSLog("indexPath:%d %@",indexPath.row, wholeArrayWithIndexPath["player"] as! String)
        cell.nameLabel.text = wholeArrayWithIndexPath["player"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var wholeArrayWithIndexPath: (AnyObject) = wholeArray[indexPath.row]
        var playerName:String = wholeArrayWithIndexPath["player"] as! String
        var playerRole:String = wholeArrayWithIndexPath["role"] as! String
        
        println("Num: \(playerName)")
        
    }
    
}
