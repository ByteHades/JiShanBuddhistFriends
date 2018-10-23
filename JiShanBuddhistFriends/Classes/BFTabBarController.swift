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
    let VCArr = [FirstViewController(),SecondViewController()]
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
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:DefineScreenWidth,height:49))
        
        
        let  MainVC  = FirstViewController()
        MainVC.title = "首页"
        let MainNav = UINavigationController(rootViewController:MainVC)
        MainNav.tabBarItem.title = "首页"
        MainNav.tabBarItem.image = UIImage(named:"first")
        MainNav.tabBarItem.selectedImage = UIImage(named:"first")
        
        let  ClassVC  = SecondViewController()
        ClassVC.title = "藏经阁"
        let ClassNav = UINavigationController(rootViewController:ClassVC)
        ClassNav.tabBarItem.title = "藏经阁"
        ClassNav.tabBarItem.image = UIImage(named:"second")
        ClassNav.tabBarItem.selectedImage = UIImage(named:"second")
        
//        let  CartVC  = CartViewController()
//        CartVC.title = "发现"
//        let CartNav = UINavigationController(rootViewController:CartVC)
//        CartNav.tabBarItem.title = "发现"
//        CartNav.tabBarItem.image = UIImage(named:"cart")
//        CartNav.tabBarItem.selectedImage = UIImage(named:"cart_blue")
//        let  MyVC  = MyViewController()
//        MyVC.title = "我的"
//        let MyNav = UINavigationController(rootViewController:MyVC)
//        MyNav.tabBarItem.title = "我的"
//        MyNav.tabBarItem.image = UIImage(named:"me")
//        MyNav.tabBarItem.selectedImage = UIImage(named:"me_blue")
        
        // 添加工具栏
        items = [MainNav,ClassNav]
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
