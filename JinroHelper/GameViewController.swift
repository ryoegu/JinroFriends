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
        
        self.getWholeArrayFromUD()
        self.makeTableView()
        
        /*// 再生管理クラス生成
        manager = BackgroundMusicManager()
        // 管理クラスに再生／一時停止を伝達
        manager!.playOrPause()*/

        
    }
    func getWholeArrayFromUD(){
        wholeArray = []
        wholeArray = saveData.objectForKey("ASSIGNED") as Array
        println(wholeArray)
        cellCount = wholeArray.count
    }
    
    func makeTableView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        seatsTableView.delegate = self
        seatsTableView.dataSource = self
        seatsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        seatsTableView.opaque=false
        seatsTableView.showsHorizontalScrollIndicator=false
        seatsTableView.showsVerticalScrollIndicator=true

/*        [mTableView setEnableInfiniteScrolling:[sender isOn]];
        [mTableView reloadData];
*/        //seatsTableView.addGestureRecognizer(tapRecognizer)
        seatsTableView.registerNib(UINib(nibName: "SeatsTableViewCell", bundle: nil), forCellReuseIdentifier: "SeatsCell")
        
        /*
        let center: AnyObject? = saveData.valueForKey("center")
        let radius = saveData.floatForKey("radius")
        let radiusCG = CGFloat(radius)
        */
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
    
    /*func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SeatsCell", forIndexPath: indexPath) as SeatsCollectionViewCell
        var wholeArrayWithIndexPath: (AnyObject) = wholeArray[indexPath.row]
        cell.nameLabel.text = wholeArrayWithIndexPath["player"] as? String
        return cell
    }*/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SeatsCell", forIndexPath: indexPath) as SeatsTableViewCell
        var wholeArrayWithIndexPath: (AnyObject) = wholeArray[indexPath.row]
        NSLog("indexPath:%d %@",indexPath.row, wholeArrayWithIndexPath["player"]? as String)
        cell.nameLabel.text = wholeArrayWithIndexPath["player"] as? String
        return cell
    }
    
    /*func handleTapGesture(sender:UITapGestureRecognizer){
        NSLog("hogehogehoge")
        if sender.state == UIGestureRecognizerState.Ended {
            var initialPinchPoint:CGPoint = sender.locationInView(seatsTableView)
            var tappedCellPath:NSIndexPath!
            tappedCellPath = nil
            tappedCellPath = self.seatsTableView?.indexPathForItemAtPoint(initialPinchPoint)?
//            indexPath = [self.folderView indexPathForItemAtPoint:CGPointMake(x,y)];

            if tappedCellPath != nil {
                //cellCount = cellCount - 1
                /*seatsCollectionView.performBatchUpdates({
                    self.seatsCollectionView.deleteItemsAtIndexPaths(NSArray(object: tappedCellPath))
                    }, completion: nil)
*/
                NSLog("tappedCellPath")
            }else{
                //                cellCount = cellCount + 1
                //                self.seatsCollectionView.performBatchUpdates({
                //                    self.seatsCollectionView.insertItemsAtIndexPaths(NSArray(object: NSIndexPath(forItem: 0, inSection: 0)))
                //                }, completion: nil)
                NSLog("tappedCellPath2")
            }

        }
    }*/
    
}



/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

//}
