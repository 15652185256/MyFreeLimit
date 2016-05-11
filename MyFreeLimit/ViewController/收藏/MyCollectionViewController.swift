//
//  MyCollectionViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/4.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController,RCAnimatedImagesViewDelegate {
    
    //数据源
    var collectionArray:NSArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.createNav()
        
        self.createView()
    }
    
    //设置导航
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "收藏";
        
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
        
        //背景图
        let bgImageVeiw = RCAnimatedImagesView(frame: CGRect(x:0, y:0 ,width:WIDTH, height:HEIGHT))
        self.view.addSubview(bgImageVeiw)
        bgImageVeiw.delegate = self
        bgImageVeiw.startAnimating()
        
        //主页面
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT))
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        //获取数据
        self.collectionArray = FMDBManager.shareInstance().selectData()
        
        //print(self.collectionArray.count)
        
        //创建九宫格
        let width1 = NSInteger((WIDTH-180)/4)
        let width2 = NSInteger(WIDTH)
        
        for i in 0...self.collectionArray.count-1 {
            
            let width3 = width1+(60+width1)*(i%3)
            
            let button = createButton(CGRect(x: width3+(i/9)*width2, y: 80+(100*(i/3%3)), width: 60, height: 60), Text: "", ImageName: "", bgImageName: "", Target: self, Method: Selector("buttonClick:"))
            button.tag = 3000+i
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
            
            
            button.sd_setBackgroundImageWithURL(NSURL(string: self.collectionArray[i]["icon"] as! String), forState: UIControlState.Normal)
            scrollView.addSubview(button)
        }
        
        var page:NSInteger = self.collectionArray.count/9
        if self.collectionArray.count%9 != 0 {
            page++
        }
        
        print(page)
        
        scrollView.contentSize = CGSize(width: width2*page, height: NSInteger(HEIGHT))
        
        //设置允许翻页
        scrollView.pagingEnabled = true
        
        //禁用滚动条,防止缩放还原时崩溃
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
    }
    
    //RCAnimatedImagesViewDelegate 代理
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named:"\(index+1).jpg")
    }

    //点击跳转
    func buttonClick(button:UIButton) {
        
        let appid = self.collectionArray[button.tag-3000]["appid"] as! String
        
        let appTitle = self.collectionArray[button.tag-3000]["name"] as! String
        
        let vc = DetailViewController()
        
        vc.appID = appid
        
        vc.appTitle = appTitle
        
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
