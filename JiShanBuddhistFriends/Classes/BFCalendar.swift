//
//  BFCalendar.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/25.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation

class BFCalendar{
    static public let mDate: Date = Date()
    
    static func getDate() -> String{
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = Calendar.current
        return formatter.string(from: Date())
    }

}
