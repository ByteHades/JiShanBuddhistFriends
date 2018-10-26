//
//  BFFastRemind.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/25.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation

class BFFastRemind {
    
    static let Instance = BFFastRemind()
    
    //地藏斋日期
    static private let mStrArrDizang: [String] = ["初一", "初八", "十四", "十五", "十八", "廿三", "廿四", "廿七", "廿八", "廿九", "三十"]
    
    //开启地藏斋提醒
    func openDizangFastRemind(){
        //生成未来30天的地藏斋推送提醒
        BFNotification.Instance.scheduleDizangFastNotification()
    }
    
    //关闭地藏斋提醒
    func closeDizangFastRemind(){
        BFNotification.Instance.clearDizangFastNotification()
    }
    
    //检查所传递日期是否是地藏斋日，默认值为今天
    static public func checkDizangDay(date:Date = Date()) -> Bool {
        //提醒地藏斋
        let calendar = Calendar.current;
        let strChineseCalendarDay = BFChineseCalendar.getDay(date: date, dateFormat: "d")
        
        for strDizangDay in mStrArrDizang {
            //如果是地藏斋中的一天的话 应该提醒
            if( strDizangDay == strChineseCalendarDay ){
                
                //如果是"廿七" 的话应该判断一下是不是月末3天 如果不是月末3天的话"廿七"不用吃斋
                if strDizangDay == "廿七"{
                    //向后加3天如果有"三十" 证明不是月末3天
                    let strCheckEndDay = BFChineseCalendar.getDay(date: calendar.date(byAdding: .day, value: 3, to: date)!, dateFormat: "d")
                    if strCheckEndDay == "三十"{
                        return false;
                    }
                }
                return true
            }
        }
        return false
    }
}
