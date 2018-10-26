//
//  BFNotification.swift
//  JiShanBuddhistFriends
//  推送消息类
//  Created by Simon on 2018/10/26.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

enum NotificationKindKey : String{
    case DizangFastKey = "Dizang"
}

class BFNotification {
    
    static let Instance = BFNotification()
    
    //发送地藏斋通知消息
    func scheduleDizangFastNotification(){
        let date = Date()
        let calendar = Calendar.current
        
        //清理当前的通知
        BFNotification.Instance.clearDizangFastNotification()
        
//        var arrNoti : [UILocalNotification] = []
        
        //根据当前日期向后检查30天的地藏斋日加入推送通知
        for i in 1...30 {
            let laterDate = calendar.date(byAdding: .day, value: i, to: date)
            if BFFastRemind.checkDizangDay(date: laterDate!){                
                let strDate = BFChineseCalendar.getDay(date: laterDate!, dateFormat: "MMMdd")
                
                //创建UILocalNotification来进行本地消息通知
                let localNotification = UILocalNotification()
                
                //将提醒时间设置为早上8点半
                var comDate = calendar.dateComponents([.year, .month, .day], from: laterDate!)
                comDate.hour = 8
                comDate.minute = 30
                comDate.second = 0
                comDate.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
                
                //推送时间
                localNotification.fireDate = calendar.date(from: comDate)
                //时区
                localNotification.timeZone = NSTimeZone.default
                //推送内容
                localNotification.alertBody = "今天是农历" + strDate + " 地藏斋吃斋日"
                //声音
                localNotification.soundName = UILocalNotificationDefaultSoundName
                //额外信息
                //待机界面的滑动动作提示
                localNotification.alertAction = "打开应用"
                // 应用程序图标右上角显示的消息数
                localNotification.applicationIconBadgeNumber = 1
                
                let nID : String = NotificationKindKey.DizangFastKey.rawValue + strDate
                
                localNotification.userInfo = ["NotificationID": nID]
                
                // fix 这里有性能问题 不应该一个一个的发送通知 应该变成数组一起发送通知
                scheduleNotification( notificationID: nID, notification: localNotification )
                
//                arrNoti.append(localNotification)
            }
        }
        
//        UIApplication.shared.scheduledLocalNotifications = arrNoti
    }
    
    //清理所有地藏斋提醒通知
    func clearDizangFastNotification(){
        cancelNotificationForKindKey(notificationKindKey: NotificationKindKey.DizangFastKey)
    }
    
    //发送通知消息
    func scheduleNotification(notificationID:String , notification:UILocalNotification){
        //如果已存在该通知消息，则先取消
        cancelNotification(notificationID: notificationID)
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    //取消某一个通知消息
    func cancelNotification(notificationID:String){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(notificationID: notificationID)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
    }
    
    //清除某一类通知
    func cancelNotificationForKindKey(notificationKindKey:NotificationKindKey){
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let id = info["NotificationID"]
            if id != nil && (id!.contains(notificationKindKey.rawValue)) {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
   func notificationForThisItem(notificationID:String)-> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let id = info["NotificationID"]
            if id != nil && id == notificationID {
                return notification as UILocalNotification
            }
        }
        return nil
    }
    
    //通过遍历所有消息推送，找到含有相应kindKey标记的
    func notificationForKindKeyItems(notificationKindKey:NotificationKindKey)-> [UILocalNotification]? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        var findNotis : [UILocalNotification]?
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let id = info["NotificationID"]
            if id != nil && (id!.contains(notificationKindKey.rawValue)) {
                if findNotis == nil{
                    findNotis = [UILocalNotification]()
                }
                
                findNotis!.append(notification)
            }
        }
        
        
        return findNotis
    }
}
