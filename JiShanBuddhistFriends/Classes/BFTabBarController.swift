//
//  BFTabBarController.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/23.
//  Copyright © 2018 Simon. All rights reserved.
//

import UIKit

class BFTabBarViewController: UITabBarController {
    
    var _backView:UIView? = nil
    var  items:NSArray = []
    let NameArr = ["首页","藏经阁","发现","我的"]
    let PicArr = ["main","grid","cart","me"]
    let PicSelectArr = ["main_blue","grid_blue","cart_blue","me_blue"]
    let VCArr = [BFBookViewController(),BFMainViewController()]
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    
    var nav:UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CreatTabBar()
    }
    
    //创建tabBar
    func CreatTabBar()  {
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:Define_ScreenWidth,height:49))

        let  MainVC  = BFMainViewController()
        MainVC.title = "首页"
        let MainNav = UINavigationController(rootViewController:MainVC)
        MainVC.tabBarItem.title = "首页"
        MainVC.tabBarItem.image = UIImage(named:"first")
        MainVC.tabBarItem.selectedImage = UIImage(named:"first")
        
        let BookVC  = BFBookViewController()
        BookVC.title = "藏经阁"
        let BookNav = UINavigationController(rootViewController:BookVC)
        BookVC.tabBarItem.title = "藏经阁"
        BookVC.tabBarItem.image = UIImage(named:"second")
        BookVC.tabBarItem.selectedImage = UIImage(named:"second")

        // 添加工具栏
        items = [MainNav, BookNav]
        self.viewControllers = items as? [UIViewController]
        for  i in 0 ..< items.count {
            /*
             (items[i] as AnyObject) 相当于 self.navigationController?
             **/
            //设置导航栏的背景图片 （优先级高）
            (items[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
            //设置导航栏的背景颜色 （优先级低）
            (items[i] as AnyObject).navigationBar.barTintColor = UIColor.white
            //设置导航栏的字体颜色
            (items[i] as AnyObject).navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
        
        /**
         for循环控制器数组 写法
         
         for  M in 0 ..< VCArr.count {
         nav = UINavigationController(rootViewController:(VCArr[M] as AnyObject as! UIViewController))
         
         nav.tabBarItem.title = NameArr[M]
         nav.tabBarItem.image = UIImage(named:PicArr[M])
         nav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[M])
         VCArr[M].title = NameArr[M]
         NavVCArr.append(nav)
         }
         // 添加工具栏
         // items = [MainNav,ClassNav,CartNav,MyNav]
         self.viewControllers = NavVCArr as? [UIViewController]
         for  i in 0 ..< NavVCArr.count {
         /*
         (items[i] as AnyObject) 相当于 self.navigationController?
         **/
         //设置导航栏的背景图片 （优先级高）
         (NavVCArr[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
         //设置导航栏的背景颜色 （优先级低）
         (NavVCArr[i] as AnyObject).navigationBar.barTintColor = UIColor.orange
         //设置导航栏的字体颜色
         (NavVCArr[i] as AnyObject).navigationBar.titleTextAttributes =
         [NSForegroundColorAttributeName: UIColor.red]
         
         }
         */
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.brown
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
//        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.white, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControl.State.normal);
//        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.red, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControl.State.selected);
//
//
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
