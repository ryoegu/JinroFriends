//
//  RoleData.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/11.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import Foundation
import CoreData

class RoleData: NSManagedObject {
    
    @NSManaged var id: NSNumber         //ID
    @NSManaged var team: NSNumber       //チーム
    @NSManaged var role: String         //役割名
    @NSManaged var number: NSNumber     //人数
    @NSManaged var type: NSNumber       //Type
    @NSManaged var valid: NSNumber      //有効かどうか(true:有効,false:無効)
    
    

}
