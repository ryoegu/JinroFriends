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
    
    @IBOutlet var seatsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getWholeArrayFromUD()
        self.makeCollectionView()
        
        
        
    }
    
    func getWholeArrayFromUD(){
        wholeArray = []
        let saveData = NSUserDefaults.standardUserDefaults()
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
                //                cellCount = cellCount - 1
                //                seatsCollectionView.performBatchUpdates({
                //                    self.seatsCollectionView.deleteItemsAtIndexPaths(NSArray(object: tappedCellPath))
                //                    }, completion: nil)
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
if (sender.state == UIGestureRecognizerStateEnded)
{
CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
NSIndexPath* tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
if (tappedCellPath!=nil)
{
self.cellCount = self.cellCount - 1;
[self.collectionView performBatchUpdates:^{
[self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];

} completion:nil];
}
else
{
self.cellCount = self.cellCount + 1;
[self.collectionView performBatchUpdates:^{
[self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
} completion:nil];
}
}
*/
//}


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

//}
