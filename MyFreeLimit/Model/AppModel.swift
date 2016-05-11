//
//  AppModel.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/4/26.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class AppModel: NSObject {

    var iconUrl: String?//应用图标
    
    var name: String?//应用名称
    var priceTrend: String?//现在价格
    var starCurrent: String?//星星
    
    var shares: String?//分享
    var currentPrice: String?//收藏
    var downloads: String?//下载
    
    var categoryName: String?//分享次数
    
    var applicationId: String?//应用ID
    
    
//    var categoryId: String?
//    
//    
//    //var description: String?
//    
//    
//    var expireDatetime: String?
//    var favorites: String?
//    var fileSize: String?
//    
//    
//    var ipa: String?
//    var itunesUrl: String?
//    var lastPrice: String?
//    
//    
//    var ratingOverall: String?
//    var releaseDate: String?
//    var releaseNotes: String?
//    
//    var slug: String?
//    
//    
//    var starOverall: String?
//    var updateDate: String?
//    var version: String?
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
