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
    
    enum EMineItem {
        enum switchBtn {
            case DizangFastRemind
            func value() -> String {
                switch self {
                case .DizangFastRemind: return "地藏斋，吃斋提醒"
                }
            }
        }
    }
    
    var mArrItem : NSArray?
    var switchBtn : UISwitch?
    
    override func viewDidLoad() {
        // 创建UISwitch开关
        //定义控件x:30 y:100 width:80 height:40
        self.view.backgroundColor = UIColor.white
        
        let labelDizang = UILabel(frame: CGRect(x: 0, y: Define_NavigationBarHeight + 50, width: Define_ScreenWidth-80, height: 40))
        labelDizang.text = EMineItem.switchBtn.DizangFastRemind.value()
        labelDizang.textAlignment = .left
        labelDizang.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(labelDizang)
        
        switchBtn = UISwitch(frame: CGRect(x: labelDizang.frame.width, y: 100, width: 80, height: 40))
        self.view.addSubview(switchBtn!)
        //设置开启状态显示的颜色
//        switchBtn!.onTintColor = UIColor.green
        //设置关闭状态的颜色
//        switchBtn!.tintColor = UIColor.gray
        //滑块上小圆点的颜色
//        switchBtn!.thumbTintColor = UIColor.white
        
        // 添加监听
        switchBtn!.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
    }
    
    func makeItem(){
        mArrItem?.adding(EMineItem.switchBtn.DizangFastRemind)
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
    @objc func switchDidChange(){
        //打印当前值
        if (switchBtn?.isOn)!{
            BFFastRemind.Instance.openDizangFastRemind()
        }else{
            BFFastRemind.Instance.closeDizangFastRemind()
        }
    }
}
