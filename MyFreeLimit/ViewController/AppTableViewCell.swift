//
//  AppTableViewCell.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/4/26.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    //应用图标
    var iconImageView: UIImageView!
    //应用名称
    var appNameLabel: UILabel!
    //现在价格
    var pricelabel: UILabel!
    //星星
    var starView: StarView!
    //分享次数
    var shareLabel: UILabel!
    //降价
    var saleLabel: UILabel!
    //分类
    var categoryLabel: UILabel!
    
    // Class 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func prepareUI() {
    
        //应用图标
        self.iconImageView = createImageView(CGRect(x:5, y:5 ,width: 44, height:44), ImageName: "")
        //切圆角
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width/2
        self.iconImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.iconImageView)
        
        
        
        //应用名称
        self.appNameLabel = createLabel(CGRect(x: 55, y: 5, width: WIDTH-55-70, height: 20), Font: 15, Text: "")
        self.contentView.addSubview(self.appNameLabel)
        
        
        //现在价格
        self.pricelabel = createLabel(CGRect(x: 55, y: 27, width: WIDTH-55-70, height: 10), Font: 10, Text: "")
        self.pricelabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.pricelabel)
        
        
        //星星
        self.starView = StarView(frame: CGRect(x: 55, y: 40, width: 65, height: 23))
        self.contentView.addSubview(self.starView)
        
        
        //分享次数
        self.shareLabel = createLabel(CGRect(x: 5, y: 60, width: WIDTH-5, height: 10), Font: 10, Text: "")
        self.shareLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.shareLabel)
        
        
        //降价
        self.saleLabel = createLabel(CGRect(x: WIDTH-60, y: 15, width: 60, height: 10), Font: 10, Text: "")
        self.saleLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.saleLabel)
        
        
        //分享次数
        self.categoryLabel = createLabel(CGRect(x: WIDTH-60, y: 30, width: 60, height: 10), Font: 10, Text: "")
        self.categoryLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.categoryLabel)
        
    }
    
    
    func configModel(model:AppModel) {

        self.iconImageView.sd_setImageWithURL(NSURL(string: model.iconUrl!), placeholderImage: UIImage(named: "account_candou.png"))
        
        self.appNameLabel.text = model.name
        
        self.pricelabel.text = model.priceTrend
        
        self.starView.configNum(model.starCurrent!)
        
        self.shareLabel.text = "分享: " + model.shares! + " 收藏: " + model.currentPrice! + " 下载: " + model.downloads!
        
        self.saleLabel.text = model.currentPrice
        
        self.categoryLabel.text = model.categoryName
    }
    
    
    // Xib 初始化
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
