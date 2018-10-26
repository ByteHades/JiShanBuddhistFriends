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
        let dateGregorianLabel = UILabel(frame: CGRect(x: 0, y: Define_NaviAddStatusHeight, width: Define_ScreenWidth, height: 20));
        dateGregorianLabel.font = UIFont.systemFont(ofSize: 18)
        
        let fastRemindLabel = UILabel(frame: CGRect(x: 0, y: Define_NaviAddStatusHeight+dateGregorianLabel.frame.height, width: Define_ScreenWidth, height: 50));
        
        //获取公历日期
        dateGregorianLabel.text = BFCalendar.getDate() + " 农历" + BFChineseCalendar.getDate(dateFormat: " MMM dd")
        
        if BFFastRemind.checkDizangDay() {
            fastRemindLabel.textColor = UIColor.red
            fastRemindLabel.text = "今天是地藏斋吃斋日"
        }
        self.view.addSubview(dateGregorianLabel)
        self.view.addSubview(fastRemindLabel)
    }
}

