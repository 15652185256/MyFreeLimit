//
//  RootViewController.swift
//  MyFreeLimit
//
//  Created by 赵晓东 on 16/4/25.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    //展示列表
    var tableView: UITableView!
    
    //数据源
    var dataArray = [AppModel]()
    
    //页数
    var NewsListPage:NSInteger!
    
    //路径
    var strUrl: NSString!
    
    //搜索
    var searchStr: NSString!
    
    //url
    var stringUrl: NSString!
    
    //搜索控制器
    //var countrySearchController = UISearchController()
    
    //搜索条
    var countrySearchBar = UISearchBar()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewsListPage = 1
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createNav()
        
        self.createView()
        
    }
    
    //点击切换刷新
    override func viewWillAppear(animated: Bool) {
        self.tableView.header?.beginRefreshing()
    }
    
    //请求数据
    func loadData() {
        
        self.stringUrl = "\(self.strUrl)?page=\(self.NewsListPage)&number=7"
        
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
    
    
    //创建头部
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        
        
        //左按钮
        let leftButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "分类", ImageName: "", bgImageName: "", Target: self, Method: Selector("leftButtonClick"))
        let item1 = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = item1
        
        
        //右按钮
        let rightButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "设置", ImageName: "", bgImageName: "", Target: self, Method: Selector("rightButtonClick"))
        let item2 = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item2
    }
    
    //分类
    func leftButtonClick() {
        let vc:CategoryViewController = CategoryViewController()
        vc.strUrl = self.strUrl
        //隐藏tabbar
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //设置
    func rightButtonClick() {
        let vc = CollectionViewController()
        //隐藏tabbar
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //创建页面
    func createView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT-64))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        self.tableView!.registerClass(AppTableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        //添加上下拉刷新
        self.tableView.addLegendHeaderWithRefreshingBlock { () -> Void in
            self.NewsListPage=1
            self.loadData()
        }
        
        self.tableView.addLegendFooterWithRefreshingBlock { () -> Void in
            self.NewsListPage = self.NewsListPage + 1
            self.loadData()
        }
        
        
        
        //配置搜索控制器
//        self.countrySearchController = ({
//            let controller = UISearchController(searchResultsController: nil)
//            controller.searchBar.delegate = self
//            self.tableView.tableHeaderView = controller.searchBar
//            
//            controller.searchBar.placeholder = "输入应用名称..."
//            controller.searchBar.tintColor = UIColor.grayColor()
//            controller.searchBar.barTintColor = UIColor.orangeColor()
//            controller.searchBar.searchBarStyle = .Minimal
//            
//            controller.hidesNavigationBarDuringPresentation = false;//不会自动隐藏导航了
//            
//            return controller
//        })()
        
        //配置搜索条
        self.countrySearchBar = UISearchBar(frame: CGRectMake(0, 0, WIDTH, 40))
//        self.countrySearchBar.placeholder = "search"
//        self.countrySearchBar.prompt = "prompt"
//        self.countrySearchBar.text = "text"
//        self.countrySearchBar.barStyle = UIBarStyle.Default
//        self.countrySearchBar.searchBarStyle = UISearchBarStyle.Default
//        self.countrySearchBar.barTintColor = UIColor.orangeColor()
//        self.countrySearchBar.tintColor = UIColor.redColor()
//        self.countrySearchBar.translucent = true
//        self.countrySearchBar.showsBookmarkButton = true
//        self.countrySearchBar.showsCancelButton = true
//        self.countrySearchBar.showsSearchResultsButton = false
//        self.countrySearchBar.showsScopeBar = false
        self.countrySearchBar.delegate = self
        self.tableView.tableHeaderView = self.countrySearchBar
        
        
    }
    
    //搜索响应
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let vc = SearchViewController()
        vc.strUrl = self.strUrl
        vc.searchStr = searchBar.text
        //隐藏tabbar
        vc.hidesBottomBarWhenPushed = true
        
        //让搜索框放弃第一焦点
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    //总行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray.count
    }
    
    //加载数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //同一形式的单元格重复使用，在声明时已注册
        let cell:AppTableViewCell = tableView.dequeueReusableCellWithIdentifier("MyCell")
            as! AppTableViewCell
        
        let model = self.dataArray[indexPath.row]
        cell.configModel(model)
        
        return cell
        
    }
    
    //cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    
    //详情
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc:DetailViewController = DetailViewController()
        
        let appModel = self.dataArray[indexPath.row]
        
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
