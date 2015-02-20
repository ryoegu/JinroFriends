//
//  GameViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/15.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var wholeArray = [AnyObject]()
    var cellCount:Int!
    let saveData = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var seatsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getWholeArrayFromUD()
        self.makeCollectionView()
        
        
        
    }
    func getWholeArrayFromUD(){
        wholeArray = []
        wholeArray = saveData.objectForKey("ASSIGNED") as Array
        println(wholeArray)
        cellCount = wholeArray.count
    }
    
    func makeCollectionView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        seatsCollectionView.delegate = self
        seatsCollectionView.dataSource = self
        seatsCollectionView.addGestureRecognizer(tapRecognizer)
        //seatsCollectionView.registerClass(Cell(), forCellWithReuseIdentifier: "MY_CELL")
        seatsCollectionView.registerNib(UINib(nibName: "SeatsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SeatsCell")
        //seatsCollectionView.backgroundColor = UIColor.blackColor()
        let center: AnyObject? = saveData.valueForKey("center")
        let radius = saveData.floatForKey("radius")
        let radiusCG = CGFloat(radius)
        
        let view:UIView = UIView(frame: CGRectMake(50, 50, 50, 50))
        view.layer.backgroundColor = UIColor.whiteColor().CGColor
        view.layer.cornerRadius = radiusCG/2.0
        self.view.addSubview(view)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SeatsCell", forIndexPath: indexPath) as SeatsCollectionViewCell
        var wholeArrayWithIndexPath: (AnyObject) = wholeArray[indexPath.row]
        cell.nameLabel.text = wholeArrayWithIndexPath["player"] as? String
        return cell
    }
    
    func handleTapGesture(sender:UITapGestureRecognizer){
        NSLog("hogehogehoge")
        if sender.state == UIGestureRecognizerState.Ended {
            var initialPinchPoint:CGPoint = sender.locationInView(seatsCollectionView)
            var tappedCellPath:NSIndexPath!
            tappedCellPath = nil
            tappedCellPath = self.seatsCollectionView?.indexPathForItemAtPoint(initialPinchPoint)?
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

//}
