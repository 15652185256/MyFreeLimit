//
//  FMDBManager.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/9.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class FMDBManager: NSObject {

    let dbPath:String
    let dbBase:FMDatabase
    
    // 单列化
    class func shareInstance() -> FMDBManager {
        struct paSingle {
            static var onceToken:dispatch_once_t = 0
            static var instance:FMDBManager? = nil
        }
        //保证单列只运行一次
        dispatch_once(&paSingle.onceToken) { () -> Void in
            paSingle.instance = FMDBManager()
        }
        return paSingle.instance!
    }
    
    override init() {
        
        let documentsFoler = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        self.dbPath = documentsFoler.stringByAppendingString("/data.db")
        
        //创建数据库
        self.dbBase = FMDatabase(path: self.dbPath as String)
        
        print("path ---- \(self.dbPath)")
        
        //打开数据库
        if dbBase.open() {
            
            let createSql:String = "create table collection (name,icon,appid)"
            
            if dbBase.executeUpdate(createSql, withArgumentsInArray: nil) {
                print("数据库创建成功!")
            } else {
                print("数据库创建失败!")
            }
        } else {
            print("Unable to open database")
        }
    }

    //收藏添加
    func addData(Dict:NSDictionary) -> Int {
        
        let collectionArray:NSArray = self.selectData()
        
        var number:Int = 0
        
        if collectionArray.count != 0 {
            
            for i in 0...collectionArray.count-1{
                let collectionDict = collectionArray[i]
                let appid = collectionDict["appid"] as! String
                let applicationId = Dict["applicationId"] as! String
                if appid == applicationId {
                    number++
                }
            }
        }
        
        if number == 0 {
            
            let arr:[AnyObject] = [Dict["name"]!,Dict["iconUrl"]!,Dict["applicationId"]!]
            
            if !self.dbBase.executeUpdate("insert into collection values(?,?,?)", withArgumentsInArray: arr) {
                
                return 0
                
            } else {
                
                return 1
            }
        } else {
            
            return 2
        }
    }
    
    
    //收藏查询
    func selectData() -> NSArray {
        
        var collectionArray = [NSDictionary]()
        
        if let rs = dbBase.executeQuery("select * from collection", withArgumentsInArray: nil) {
            
            while rs.next() {
                
                let name:String = rs.stringForColumn("name")
                let icon:String = rs.stringForColumn("icon")
                let appid:String = rs.stringForColumn("appid")
                
                let dict = ["name":name,"icon":icon,"appid":appid]
                collectionArray.append(dict)
            }
            
        } else {
            print("查询失败 failed: \(dbBase.lastErrorMessage())")
        }
        
        return collectionArray
    }
    
}
