//
//  BFNotification.swift
//  JiShanBuddhistFriends
//  推送消息类
//  Created by Simon on 2018/10/26.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

class BFNotification {
    
    static let Instance = BFNotification()
    
    //发送地藏斋通知消息
    func scheduleDizangFastNotification(){
        let date = Date()
        let calendar = Calendar.current
        
        //清理地藏斋类型的通知
        cancelNotificationForKindKey(notificationKindKey: NotificationKindKey.DizangFastKey)
                
        //根据当前日期向后检查30天的地藏斋日加入推送通知
        for i in 1...30 {
            let laterDate = calendar.date(byAdding: .day, value: i, to: date)
            if BFFastRemind.checkDizangDay(date: laterDate!){                
                let strDate = BFChineseCalendar.getDay(date: laterDate!, dateFormat: "MMMdd")
                
                //设置请求标识符
                let nID : String = NotificationKindKey.DizangFastKey.rawValue + strDate
                //设置推送内容
                let content = UNMutableNotificationContent()
                content.title = "吃斋提醒"
                content.body = "今天是农历" + strDate + " 地藏斋吃斋日"
                content.userInfo = ["NotificationID": nID]
                content.sound = UNNotificationSound.default
                content.badge = 1
                
                // 定义触发的时间组合
                //将提醒时间设置为早上8点半
                var matchingDate = calendar.dateComponents([.year, .month, .day], from: laterDate!)
                matchingDate.hour = 8
                matchingDate.minute = 30
                matchingDate.second = 0
                matchingDate.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
                //设置通知触发器
                let trigger =  UNCalendarNotificationTrigger.init(dateMatching: matchingDate, repeats: true)
                 
                //设置一个通知请求
                let request = UNNotificationRequest(identifier: nID,
                                                    content: content, trigger: trigger)
                 
                // fix 这里有性能问题 不应该一个一个的发送通知 应该变成数组一起发送通知
                scheduleNotification( notificationID: nID, notification: request )
            }
        }
        
//        UIApplication.shared.scheduledLocalNotifications = arrNoti
    }
    
    //清理所有地藏斋提醒通知
    func clearDizangFastNotification(){
        cancelNotificationForKindKey(notificationKindKey: NotificationKindKey.DizangFastKey)
    }
    
    //发送通知消息
    func scheduleNotification(notificationID:String , notification:UNNotificationRequest){
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(notification) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(notificationID)")
            } else {
                print("通知添加成功")
            }
        }
    }
    
    //取消某一个通知消息
    func cancelNotification(notificationID:String){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(notificationID: notificationID)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationID])
        }
    }
    
    //清除某一类通知
    func cancelNotificationForKindKey(notificationKindKey:NotificationKindKey){
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { (allNotifications) in
            var arrID : [String] = []
            for notification in allNotifications {
                let info = notification.request.content.userInfo as! [String:String]
                let id = info["NotificationID"]
                if id != nil && (id!.contains(notificationKindKey.rawValue)) {
                    arrID.append(id ?? "")
                }
            }
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: arrID)
        })
        
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
