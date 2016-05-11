//
//  MainTabBarController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/4/25.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createViewContollers()
    }
    
    
    
    func createViewContollers() {
        
        let vc1 = LimitViewController()
        vc1.strUrl = LIMIT
        let firstVC = UINavigationController(rootViewController: vc1)
        let item1 : UITabBarItem = UITabBarItem (title: "限免", image: UIImage(named: "tabbar_limitfree.png"), selectedImage: UIImage(named: "tabbar_limitfree_press.png"))
        firstVC.tabBarItem = item1
        
        let vc2 = SaleViewController()
        vc2.strUrl = SALE
        let secondVC = UINavigationController(rootViewController: vc2)
        let item2 : UITabBarItem = UITabBarItem (title: "降价", image: UIImage(named: "tabbar_reduceprice.png"), selectedImage: UIImage(named: "tabbar_reduceprice_press.png"))
        secondVC.tabBarItem = item2
        
        let vc3 = FreeViewController()
        vc3.strUrl = FREE
        let otherVC = UINavigationController(rootViewController: vc3)
        let item3 : UITabBarItem = UITabBarItem (title: "免费", image: UIImage(named: "tabbar_appfree.png"), selectedImage: UIImage(named: "tabbar_appfree_press.png"))
        otherVC.tabBarItem = item3
        
        let vc4 = HotViewController()
        vc4.strUrl = HOT
        let fourVC = UINavigationController(rootViewController: vc4)
        let item4 : UITabBarItem = UITabBarItem (title: "热榜", image: UIImage(named: "tabbar_rank.png"), selectedImage: UIImage(named: "tabbar_rank_press.png"))
        fourVC.tabBarItem = item4
        
        let tabArray = [firstVC,secondVC,otherVC,fourVC]
        self.viewControllers = tabArray
        
        
        //.自定义工具栏
        self.tabBar.backgroundImage = UIImage(named: "tabber_bg.png")
        
        //.设置底部工具栏文字颜色（默认状态和选中状态）
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:RGBA (152.0, g:153.0, b: 154.0, a: 1), forKey:NSForegroundColorAttributeName) as? [String : AnyObject], forState:UIControlState.Normal);
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:RGBA (119.0, g:142.0, b: 28.0, a: 1), forKey:NSForegroundColorAttributeName) as? [String : AnyObject], forState:UIControlState.Selected)
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
