//
//  CollectionViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/4.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,RCAnimatedImagesViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        //self.view.layer.contents = UIImage(named:"1.jpg")!.CGImage
        
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
        self.navigationItem.title = "设置";
        
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
    
    //创建页面
    func createView() {
        
        //背景图
        let bgImageVeiw = RCAnimatedImagesView(frame: CGRect(x:0, y:0 ,width:WIDTH, height:HEIGHT))
        self.view.addSubview(bgImageVeiw)
        bgImageVeiw.delegate = self
        bgImageVeiw.startAnimating()
        
        //名称
        let titleArray = ["我的设置","我的关注","我的账号","我的收藏","我的下载","我的评论","我的帮助","蚕豆应用"]
        //图片
        let imageArray = ["account_setting.png","account_favorite.png","account_user.png","account_collect.png","account_download.png","account_comment.png","account_help.png","account_candou.png"]
        
        let width = Float((WIDTH-180)/4)
        
        for i in 0...imageArray.count-1{
            
            let column = Float(i%3)
            
            let width1 = Int(width+(60+width)*column)
            
            //按钮
            let imageButton = createButton(CGRect(x: width1, y: 120+(100*(i/3)), width: 60, height: 60), Text: "", ImageName: imageArray[i], bgImageName: "", Target: self, Method: Selector("buttonClick:"))
            imageButton.tag = 3000 + i
            self.view.addSubview(imageButton)
            
            
            //标题
            let titleLabel = createLabel(CGRect(x: 0, y: 65, width: 60, height: 20), Font: 12, Text: titleArray[i])
            titleLabel.textAlignment = NSTextAlignment.Center
            imageButton.addSubview(titleLabel)
            //titleLabel.textColor = UIColor.whiteColor()
        }
    }
    
    
    //RCAnimatedImagesViewDelegate 代理
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named:"\(index+1).jpg")
    }
    
    
    func buttonClick(button:UIButton) {
        
        switch button.tag-3000 {
        case 0:
            //我的设置
            break
        case 1:
            //我的关注
            break
        case 2:
            //我的账号
            break
        case 3:
            //我的收藏
            let vc = MyCollectionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            //我的下载
            break
        case 5:
            //我的评论
            break
        case 6:
            //我的帮助
            break
        case 7:
            //蚕豆应用
            break
        default:
            break
        }
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
