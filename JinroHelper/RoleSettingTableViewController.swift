//
//  RoleSettingTableViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/06.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class RoleSettingTableViewController: UITableViewController {
    @IBOutlet var roleTableView: UITableView!

    var roleArray = [["占い師","1"],["霊媒師","0"],["狩人","0"],["恋人","0"],["村人","0"],["人狼","1"],["狂人","0"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: "RoleSettingTableViewCell", bundle: nil)
        roleTableView.registerNib(xib,forCellReuseIdentifier:"Cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as RoleSettingTableViewCell
        cell.roleLabel.text = roleArray[indexPath.row][0]
        cell.plusButton.addTarget(self, action: "plusMethod:event:", forControlEvents: .TouchUpInside)
        cell.minusButton.addTarget(self, action: "minusMethod:event:", forControlEvents: .TouchUpInside)
        cell.roleNumberLabel.text = roleArray[indexPath.row][1]
        return cell
    }
    
    func plusMethod(sender:UIButton, event:UIEvent){
        
        let touch:UITouch = event.allTouches()?.anyObject() as UITouch
        let point:CGPoint = touch.locationInView(roleTableView)
        let indexPath:NSIndexPath = roleTableView.indexPathForRowAtPoint(point)!
        var roleNumber = roleArray[indexPath.row][1].toInt()!
        roleNumber++
        roleArray[indexPath.row][1]=String(roleNumber)
        NSLog("%@",roleArray)
        roleTableView.reloadData()
//        cell.roleNumberLabel.text = roleArray[indexPath.row][1]
        
    }
    func minusMethod(sender:UIButton, event:UIEvent){
        let touch:UITouch = event.allTouches()?.anyObject() as UITouch
        let point:CGPoint = touch.locationInView(roleTableView)
        let indexPath:NSIndexPath = roleTableView.indexPathForRowAtPoint(point)!
        var roleNumber = roleArray[indexPath.row][1].toInt()!
        if roleNumber > 0{
            roleNumber--
        }
        roleArray[indexPath.row][1]=String(roleNumber)
        NSLog("%@",roleArray)
        roleTableView.reloadData()
//        cell.roleNumberLabel.text = roleArray[indexPath.row][1]

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
