//
//  AssignViewController.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/12.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class AssignViewController: UIViewController {

    @IBOutlet var explainLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    var roleArray = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func assignButton(sender: UIButton) {
    }

    @IBAction func nextButton(sender: UIButton) {
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
