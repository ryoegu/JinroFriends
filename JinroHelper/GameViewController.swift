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
        let count = wholeArray.count
        NSLog("%d", count)
        return wholeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SeatsCell", forIndexPath: indexPath) as SeatsCollectionViewCell
        return cell
    }
    
    func handleTapGesture(sender:UITapGestureRecognizer){
        NSLog("hogehogehoge")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
