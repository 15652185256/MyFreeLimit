//
//  DetailViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/5.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController,CLLocationManagerDelegate {
    
    //appID
    var appID:String!
    //标题
    var appTitle:String!
    
    //背景图
    var detailImageView:UIImageView!
    //图标
    var iconImageView:UIImageView!
    //应用名称
    var appNameLabel:UILabel!
    //价格
    var priceLabel:UILabel!
    //类型
    var typeLabel:UILabel!
    
    //展示图片
    var detailScrollView:UIScrollView!
    //说明
    var detailLabel:UILabel!
    
    //图片数组
    var photoArray: NSArray!
    
    //数据
    var dataDict:NSDictionary!
    
    //附近人的 imageView
    var findImageView:UIImageView!
    
    //附近人的 ScrollView
    var findScrollView:UIScrollView!
    
    //定位 
    var locateManage:CLLocationManager!
    
    //定位 数据
    var dataArray = [AppModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createNav()
        
        self.createView()
        
        self.loadData()
        
        //创建定位
        self.createLocationManager()
    }
    
    
    //设置导航
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = self.appTitle;
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        
        //返回按钮
        let returnButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "< 返回", ImageName: "", bgImageName: "", Target: self, Method: Selector("returnButtonClick"))
        let item1 = UIBarButtonItem(customView: returnButton)
        self.navigationItem.leftBarButtonItem = item1
    }
    
    
    //返回
    func returnButtonClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //设置页面
    func createView() {
        
        self.detailImageView = createImageView(CGRect(x: 10, y: 10, width: WIDTH-20, height: 300), ImageName: "appdetail_background.png")
        self.view.addSubview(self.detailImageView)
        
        self.iconImageView = createImageView(CGRect(x: 9, y: 12, width: 50, height: 50), ImageName: "")
        self.detailImageView.addSubview(self.iconImageView)
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.layer.cornerRadius = 5
        
        self.appNameLabel = createLabel(CGRect(x: 68, y: 8, width: WIDTH-20-64, height: 20), Font: 12, Text: "应用名称")
        self.detailImageView.addSubview(self.appNameLabel)
        
        self.priceLabel = createLabel(CGRect(x: 68, y: 28, width: WIDTH-20-64, height: 20), Font: 10, Text: "免费中。。")
        self.priceLabel.textColor = UIColor.grayColor()
        self.detailImageView.addSubview(self.priceLabel)
        
        self.typeLabel = createLabel(CGRect(x: 68, y: 48, width: WIDTH, height: 20), Font: 10, Text: "类型")
        self.typeLabel.textColor = UIColor.grayColor()
        self.detailImageView.addSubview(self.typeLabel)
        
        
        let titleArray = ["分享","收藏","下载"]
        for i in 0...titleArray.count-1{
            
            let width1 = NSInteger((WIDTH-20)/3-8)
            
            let titleButton = createButton(CGRect(x: 6+i*(width1+6), y: 70, width: width1, height: 40), Text: titleArray[i], ImageName: "", bgImageName: "", Target: self, Method: Selector("titleButtonClick:"))
            titleButton.tag = 3000+i
            
            //使触摸模式下按钮也不会变暗
            //titleButton.adjustsImageWhenHighlighted = false
            
            //进行图片拉伸
            let titleImage = UIImage(named:"buttonbar_action.png")
            titleImage?.stretchableImageWithLeftCapWidth(10, topCapHeight: 10)
            titleButton.setBackgroundImage(titleImage, forState: UIControlState.Normal)
            titleButton.titleLabel?.font = UIFont.systemFontOfSize(15)
            titleButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            self.detailImageView.addSubview(titleButton)
            
            //高亮状态下文字的颜色
            titleButton.setTitleColor(UIColor.whiteColor(),forState:.Highlighted)

        }
        
        self.detailScrollView = UIScrollView(frame: CGRect(x: 10, y: 108+10, width: WIDTH-20, height: 130))
        self.view.addSubview(self.detailScrollView)
        
        self.detailLabel = createLabel(CGRect(x: 10, y: 230, width: WIDTH-40, height: 60), Font: 10, Text: "应用说明")
        self.detailLabel.numberOfLines = 0
        self.detailLabel.textColor = UIColor.grayColor()
        self.detailImageView.addSubview(self.detailLabel)
        
        
        self.findImageView = createImageView(CGRect(x: 10, y: 320, width: WIDTH-20, height: 120), ImageName: "appdetail_recommend.png")
        self.view.addSubview(self.findImageView)
        print(WIDTH-20)
        
        self.findScrollView = UIScrollView(frame: CGRect(x: 5, y: 20, width: WIDTH-30, height: 80))
        self.findImageView.addSubview(self.findScrollView)
    }
    
    
    //收藏
    func titleButtonClick(button:UIButton) {
        switch button.tag-3000 {
        case 0:
            //分享
            break
        case 1:
            //收藏
            if self.dataDict == nil {
                return
            }
            
            let isSucceed = FMDBManager.shareInstance().addData(self.dataDict)
            var alertStr:String!
            
            if isSucceed == 0 {
                alertStr = "收藏失败"
            } else if isSucceed == 1 {
                alertStr = "收藏成功"
            } else if isSucceed == 2 {
                alertStr = "您已收藏该应用,无需再次收藏"
            }
            
            print(alertStr)
            
            break
        case 2:
            //下载
            break
        default:
            break
        }
    }
    
    //请求数据
    func loadData() {
        
        let detailUrl = "http://iappfree.candou.com:8080/free/applications/\(self.appID)?currency=rmb"
        
        
        
//        let url: NSURL = NSURL(string: detailUrl)!
//        let request: NSURLRequest = NSURLRequest(URL: url)
//        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
//            (response, data, error) -> Void in
//            
//            if ((error) != nil) {
//                //Handle Error here
//                return
//            }else{
//                //Hanqdle data in NSData type
//                
//                let dataDict : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
//                //print("Json Object:"); print(json)
//                
//                self.iconImageView.sd_setImageWithURL(NSURL(string: (dataDict["iconUrl"] as? String)!))
//                self.appNameLabel.text = dataDict["name"] as? String
//                self.priceLabel.text = dataDict["lastPrice"] as? String
//                self.typeLabel.text = dataDict["categoryName"] as? String
//                self.detailLabel.text = dataDict["description"] as? String
//                
//                
//                //动态创建imageview
//                self.photoArray = dataDict["photos"] as! NSArray
//                for i in 0...self.photoArray.count-1{
//        
//                    let imageView = createImageView(CGRect(x: 10+90*i, y: 10, width: 80, height: 110), ImageName: "20140808113431_z8Mnz.thumb.700_0.jpeg")
//                    
//                    let photoDict = self.photoArray[i] as! NSDictionary
//                    
//                    imageView.sd_setImageWithURL(NSURL(string: (photoDict["smallUrl"] as? String)!))
//                    imageView.tag = 4000+i
//                    self.detailScrollView.addSubview(imageView)
//                    
//                    
//                    //设置允许交互属性
//                    imageView.userInteractionEnabled = true
//                    
//                    //添加tapGuestureRecognizer手势
//                    let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
//                    imageView.addGestureRecognizer(tapGR)
//                    
//                }
//                
//                self.detailScrollView.contentSize = CGSize(width: self.photoArray.count*90+10, height: 130)
//                
//                //禁用滚动条,防止缩放还原时崩溃
//                self.detailScrollView.showsHorizontalScrollIndicator = false
//                self.detailScrollView.showsVerticalScrollIndicator = false
//                self.detailScrollView.bounces = false
//                
//                
//                
//            }
//            
//        })

        
        let manager = AFHTTPSessionManager()
        
        //请求格式
        manager.requestSerializer = AFJSONRequestSerializer()
        
        //返回格式
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.GET(detailUrl, parameters: "", progress: { (uploadProgress: NSProgress!) -> Void in
            
            }, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                if ((responseObject!.description) != nil) {
                    
                    self.dataDict = responseObject as! NSDictionary
                    //print(dataDict);
                    
          
                    self.iconImageView.sd_setImageWithURL(NSURL(string: (self.dataDict["iconUrl"] as? String)!), placeholderImage: UIImage(named: "account_candou.png"))
                    self.appNameLabel.text = self.dataDict["name"] as? String
                    self.priceLabel.text = self.dataDict["lastPrice"] as? String
                    self.typeLabel.text = self.dataDict["categoryName"] as? String
                    self.detailLabel.text = self.dataDict["description"] as? String
                    
                    
                    //动态创建imageview
                    self.photoArray = self.dataDict["photos"] as! NSArray
                    for i in 0...self.photoArray.count-1{
                        
                        let imageView = createImageView(CGRect(x: 10+90*i, y: 10, width: 80, height: 110), ImageName: "20140808113431_z8Mnz.thumb.700_0.jpeg")
                        
                        let photoDict = self.photoArray[i] as! NSDictionary
                        
                        imageView.sd_setImageWithURL(NSURL(string: (photoDict["smallUrl"] as? String)!))
                        imageView.tag = 4000+i
                        self.detailScrollView.addSubview(imageView)
                        
                        
                        //设置允许交互属性
                        imageView.userInteractionEnabled = true
                        
                        //添加tapGuestureRecognizer手势
                        let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
                        imageView.addGestureRecognizer(tapGR)
                        
                    }
                    
                    self.detailScrollView.contentSize = CGSize(width: self.photoArray.count*90+10, height: 130)
                    
                    //禁用滚动条,防止缩放还原时崩溃
                    self.detailScrollView.showsHorizontalScrollIndicator = false
                    self.detailScrollView.showsVerticalScrollIndicator = false
                    self.detailScrollView.bounces = false
                }
                
            }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("Error: " + error.localizedDescription)
        }
        
    }
    

    //点击图片
    func tapHandler(sender:UITapGestureRecognizer) {
        
        let index = NSInteger((sender.view?.tag)! - 4000)
        
        unowned let weakSelf = self
        
        PhotoBroswerVC.show(weakSelf, type: PhotoBroswerVCTypeZoom, index: index) { () -> [AnyObject]! in
            
            var modelsM = [PhotoModel]()
            
            for i in 0...self.photoArray.count-1 {
                
                let pbModel = PhotoModel()
                pbModel.mid = i + 1
                pbModel.title = ""
                pbModel.desc = ""
                
                let photoDict = self.photoArray[i] as! NSDictionary
                pbModel.image_HD_U = photoDict["originalUrl"] as! String
                
                //源frame
                let imageV = weakSelf.detailScrollView.subviews[i] as! UIImageView
                pbModel.sourceImageView = imageV
                
                modelsM.append(pbModel)
            }
            
            return modelsM
        }
    }
    
    //创建定位
    func createLocationManager() {
    
        self.locateManage = CLLocationManager()
        
        self.locateManage.delegate = self
        
        self.locateManage.distanceFilter = 1000
        //请求定位权限
        if self.locateManage.respondsToSelector(Selector("requestAlwaysAuthorization")) {
            self.locateManage.requestAlwaysAuthorization()
        }
        
        self.locateManage.desiredAccuracy = kCLLocationAccuracyBest//定位精准度
        self.locateManage.startUpdatingLocation()//开始定位
    }
    
    
    //定位成功 返回一段数据
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("定位成功")
        
        if let newLocation:CLLocation = locations.last {
            
            print(newLocation.coordinate.longitude,newLocation.coordinate.latitude)
            
            let str:String = "http://iappfree.candou.com:8080/free/applications/recommend?longitude=\(newLocation.coordinate.longitude)&latitude=\(newLocation.coordinate.latitude)"
            
            self.findLoadData(str)
        }

        //关闭定位
        self.locateManage.stopUpdatingLocation()
    }
    
    //定位失败
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("定位失败")
        
        //关闭定位
        self.locateManage.stopUpdatingLocation()
    }
    
    //附近人常用
    func findLoadData(urlStr:String) {
        
        let manager = AFHTTPSessionManager()
        
        //请求格式
        manager.requestSerializer = AFJSONRequestSerializer()
        
        //返回格式
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.GET(urlStr, parameters: "", progress: { (uploadProgress: NSProgress!) -> Void in
            
            }, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                if ((responseObject!.description) != nil) {
                    
                    let someArray = responseObject!["applications"] as! NSArray
                    
                    for dict in someArray {
                        let model = AppModel()
                        model.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArray.append(model)
                    }
                    
                    //创建相关应用图标在findScrollView
                    for i in 0...self.dataArray.count-1 {
                        let button = createButton(CGRect(x: 5+70*i, y:15, width: 60, height: 60), Text: "", ImageName: "", bgImageName: "", Target: self, Method: Selector("appClick:"))
                        button.tag = 2000+i
                        button.layer.masksToBounds = true
                        button.layer.cornerRadius = 5
                        
                        let model = self.dataArray[i]
                        button.sd_setBackgroundImageWithURL(NSURL(string: model.iconUrl!), forState: UIControlState.Normal, placeholderImage: UIImage(named: "account_candou.png"))
                        self.findScrollView.addSubview(button)
                    }
                    self.findScrollView.contentSize = CGSize(width: self.dataArray.count*70, height: 44)
                    
                    //禁用滚动条,防止缩放还原时崩溃
                    self.findScrollView.showsHorizontalScrollIndicator = false
                    self.findScrollView.showsVerticalScrollIndicator = false
                    self.findScrollView.bounces = false
                }
                
            }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("Error: " + error.localizedDescription)
        }
    }
    
    func appClick(button:UIButton) {
    
        let appModel = self.dataArray[button.tag-2000]
        
        let vc = DetailViewController()
        
        vc.appID = appModel.applicationId
        
        vc.appTitle = appModel.name
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
