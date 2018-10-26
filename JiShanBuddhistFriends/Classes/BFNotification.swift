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
    
    static let sharedInstance = BFNotification()
    
    //发送地藏斋通知消息
    func scheduleDizangFastNotification(){
        //根据当前日期向后检查90天的地藏斋日加入推送通知
        for i in 1...90 {
            let date = Date()
            let calendar = Calendar.current
            let laterDate = calendar.date(byAdding: .day, value: i, to: date)
            if BFFastRemind.checkDizangDay(date: laterDate!){
                print()
                
                let strDate = BFChineseCalendar.getDay(date: laterDate!, dateFormat: "MMMdd")
                
                //创建UILocalNotification来进行本地消息通知
                let localNotification = UILocalNotification()
                //推送时间（设置为30秒以后）
                localNotification.fireDate = laterDate
                //时区
                localNotification.timeZone = NSTimeZone.default
                //推送内容
                localNotification.alertBody = "今天是农历" + strDate + " 地藏斋"
                //声音
                localNotification.soundName = UILocalNotificationDefaultSoundName
                //额外信息
                
                let nID : String = NotificationKindKey.DizangFastKey.rawValue + strDate
                
                localNotification.userInfo = ["NotificationID": nID]
                
                scheduleNotification( notificationID: nID, notification: localNotification )
            }
        }
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
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForKindKeyItem(notificationKindKey: notificationKindKey.rawValue)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.shared.cancelLocalNotification(existingNotification!)
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
    func notificationForKindKeyItem(notificationKindKey:String)-> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let id = info["NotificationID"]
            if id != nil && (id!.contains(notificationKindKey)) {
                return notification as UILocalNotification
            }
        }
        return nil
    }
}
