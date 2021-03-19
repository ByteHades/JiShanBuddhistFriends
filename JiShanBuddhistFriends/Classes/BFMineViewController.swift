//
//  BFMineViewController.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/26.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

class BFMineViewController : UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var mArrItem : NSArray?
    
    override func viewDidLoad() {
        // 创建UISwitch开关
        //定义控件x:30 y:100 width:80 height:40
        self.view.backgroundColor = UIColor.init(red: 239/255.0, green: 238/255.0, blue: 242/255.0, alpha: 1)
        
        
        let itemView = UIView(frame: CGRect(x: 0, y: Define_NavigationBarHeight + 50, width: Define_ScreenWidth, height: 40))
        itemView.backgroundColor = UIColor.white
        let labelDizang = UILabel(frame: CGRect(x: 20, y: (itemView.frame.height - 24)/2, width: 200, height: 24))
        labelDizang.text = EMineSwitchItem.switchBtn.DizangFastRemind.value()
        labelDizang.font = UIFont.systemFont(ofSize: 18)
        itemView.addSubview(labelDizang)
        
        let switchBtn = UISwitch()
        switchBtn.frame.origin = CGPoint(x: itemView.frame.width - switchBtn.frame.width*1.5, y: (itemView.frame.height - switchBtn.frame.height)/2)
        switchBtn.isOn = UserDefaults.standard.bool(forKey: Define_UserDefaultsKey_DizangFastRemind)
        itemView.addSubview(switchBtn)
        
        // 添加监听
        switchBtn.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        
        self.view.addSubview(itemView)
    }
    
    func makeItem(){
        mArrItem?.adding(EMineSwitchItem.switchBtn.DizangFastRemind)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
//    /**
//     UISwitch监听方法
//     */
//    func switchDidChange() {
//        print(switchBtn.isOn)
//    }
//    @objc
    @objc func switchDidChange(sender: UISwitch){
        //打印当前值
        if (sender.isOn){
            BFFastRemind.Instance.openDizangFastRemind()
        }else{
            BFFastRemind.Instance.closeDizangFastRemind()
        }
        
        //把当前状态保存起来
        UserDefaults.standard.set(sender.isOn, forKey: Define_UserDefaultsKey_DizangFastRemind)
    }
}
