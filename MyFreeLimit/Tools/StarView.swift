//
//  StarView.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/4.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class StarView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    //黄色的星星
    var starImageView:UIImageView!
    
    //背景色的星星
    var bgStarImageView:UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景色的星星
        self.bgStarImageView = createImageView(CGRect(x: 0, y: 0, width: 65, height: 23), ImageName:"StarsBackground.png")
        self.addSubview(self.bgStarImageView)
        
        
        //黄色的星星
        self.starImageView = createImageView(CGRect(x: 0, y: 0, width: 65, height: 23), ImageName:"StarsForeground.png")
        self.addSubview(self.starImageView)
        //设置停靠模式
        starImageView.contentMode = UIViewContentMode.Left
        //多余部分裁剪
        starImageView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //设置一个方法,具体是几颗星
    func configNum(num:String) {
        let number = (num as NSString).integerValue
        self.starImageView.frame = CGRect(x: 0, y: 0, width: 65/5*number, height: 23)
        //CGRect(x: 0.0, y: 0.0, width: 65/5*number, height: 23.0)
    }

}
