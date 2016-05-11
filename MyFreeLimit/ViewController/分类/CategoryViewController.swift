//
//  CategoryViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/5/4.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //路径
    var strUrl: NSString!
    
    //展示列表
    var tableView: UITableView!
    
    //数据源
    var dataArray = [NSDictionary]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.createNav()
        
        self.createView()
    }
    
    //刷新
    override func viewWillAppear(animated: Bool) {
        self.loadData()
    }
    
    
    //设置导航
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "分类";
        
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
        self.tableView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT-64))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    
    //总行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray.count
    }
    
    //加载数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //同一形式的单元格重复使用，在声明时已注册
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyCell")
        }
        
        let dict:NSDictionary = self.dataArray[indexPath.row]
        
        cell!.textLabel?.text = dict["categoryCname"] as? String
        cell!.detailTextLabel?.text = "一共有\(dict["categoryCount"])款应用,其中限免\(dict["limited"])款"
        cell!.detailTextLabel?.font = UIFont.systemFontOfSize(10)
        cell!.detailTextLabel?.textColor = UIColor.grayColor()
 
        return cell!
        
    }
    
    //cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    //请求数据
    func loadData() {
        
        let manager = AFHTTPSessionManager()
        
        //请求格式
        manager.requestSerializer = AFJSONRequestSerializer()
        
        //返回格式
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.GET(CATEGORY, parameters: "", progress: { (uploadProgress: NSProgress!) -> Void in
            
            }, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                if ((responseObject!.description) != nil) {
                    
                    self.dataArray.removeAll()
                    
                    //获取结果
                    let someArray = responseObject as! NSArray
                    
                    self.dataArray = someArray as! [NSDictionary]
                    
                    self.tableView.reloadData()
                }
                
            }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                
        }
    }
    
    //点击切换
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc:CategoryNewsListViewController = CategoryNewsListViewController()
        
        let cateID = self.dataArray[indexPath.row]["categoryId"] as? String
        
        let cateTitle = self.dataArray[indexPath.row]["categoryCname"] as? String
        
        vc.cateTitle = cateTitle
        vc.cateID = cateID
        vc.strUrl = self.strUrl
        
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
