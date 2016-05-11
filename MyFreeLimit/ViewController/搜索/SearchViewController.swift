//
//  SearchViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/4/29.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class SearchViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = nil
    }
    
    //设置导航
    override func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "搜索";
        
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
    
    
    //请求数据
    override func loadData() {
        
        self.stringUrl = "\(self.strUrl)?page=\(self.NewsListPage)&number=7&search=\(self.searchStr)"
        
        let manager = AFHTTPSessionManager()
        
        //请求格式
        manager.requestSerializer = AFJSONRequestSerializer()
        
        //返回格式
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.GET(self.stringUrl as String, parameters: "", progress: { (uploadProgress: NSProgress!) -> Void in
            
            }, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                if ((responseObject!.description) != nil) {
                    
                    if self.NewsListPage==1 {
                        self.dataArray.removeAll()
                    }
                    
                    let someArray = responseObject!["applications"] as! NSArray
                    
                    for dict in someArray {
                        let model = AppModel()
                        model.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArray.append(model)
                    }
                    
                    self.tableView.reloadData()
                    
                    self.tableView.header?.endRefreshing()
                    self.tableView.footer?.endRefreshing()
                }
                
            }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("Error: " + error.localizedDescription)
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
