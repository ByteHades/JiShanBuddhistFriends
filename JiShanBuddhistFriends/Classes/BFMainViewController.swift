//
//  SecondViewController.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/23.
//  Copyright © 2018 Simon. All rights reserved.
//

import UIKit

class BFMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //设置应用程序右上角的提醒个数
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Do any additional setup after loading the view, typically from a nib.
        self.ShowView()
    }
    
    func ShowView() {
        let jsonPath = Bundle.main.path(forResource: "MainImage", ofType:"jpeg")
        let imgView = UIImageView(frame: CGRect(x: 0, y: Define_NaviAddStatusHeight, width: Define_ScreenWidth, height: Define_ViewHeight))
        imgView.image = UIImage(contentsOfFile: jsonPath ?? "MainImage.jpeg")
        imgView.contentMode = UIView.ContentMode.scaleToFill
//        self.view.addSubview(imgView)
        
        //显示农历日期 和 吃斋提醒
        let dateGregorianLabel = UILabel(frame: CGRect(x: 0, y: Define_NaviAddStatusHeight, width: Define_ScreenWidth, height: 18));
        dateGregorianLabel.font = UIFont.systemFont(ofSize: 18)
        
        let fastRemindLabel = UILabel(frame: CGRect(x: 0, y: Define_NaviAddStatusHeight+dateGregorianLabel.frame.height, width: Define_ScreenWidth, height: 24));
        fastRemindLabel.font = UIFont.systemFont(ofSize: 24)

        //获取公历日期
        dateGregorianLabel.text = BFCalendar.getDate() + " 农历" + BFChineseCalendar.getDate(dateFormat: " MMM dd")
        
        if BFFastRemind.checkDizangDay() {
            fastRemindLabel.textColor = UIColor.red
            fastRemindLabel.text = "今天是地藏斋吃斋日"
        }
        self.view.addSubview(dateGregorianLabel)
        self.view.addSubview(fastRemindLabel)
        
        //判断本地吃斋提醒是不是不够了，不足5条的话自动重新获取推送
        let isOpenDzFast = UserDefaults.standard.bool(forKey: Define_UserDefaultsKey_DizangFastRemind)
        if isOpenDzFast {
            let dzFastNotis = BFNotification.Instance.notificationForKindKeyItems(notificationKindKey: NotificationKindKey.DizangFastKey)
            if dzFastNotis == nil || dzFastNotis!.count < 5 {
                BFNotification.Instance.scheduleDizangFastNotification()
            }
        }
    }
}

