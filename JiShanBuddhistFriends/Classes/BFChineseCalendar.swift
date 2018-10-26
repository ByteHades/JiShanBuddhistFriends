//
//  BFChineseCalendar.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/26.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation

class BFChineseCalendar {
    
    static private let mStrArrZodiacs: [String] = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    static private let mStrArrHeavenlyStems: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    static private let mStrArrEarthlyBranches: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    
    //根据公历年、月、日获取对应的农历日期信息
    static public func solarToLunar(year: Int, month: Int, day: Int) -> String {
        //初始化公历日历
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)
        
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!)
    }
    
    //根据公历当前日期获取对应的农历日期信息
    static func getDate(dateFormat:String = "") -> String {
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .full
//        formatter.dateFormat = "MMM dd EEEE"
        if !dateFormat.isEmpty{
            formatter.dateFormat = dateFormat
        }
        formatter.calendar = lunarCalendar
        return formatter.string(from: Date())
    }
    
    
    //根据传递进来的日期计算农历日期
    static public func getDay(date:Date, dateFormat:String = "") -> String {
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        if !dateFormat.isEmpty{
            formatter.dateFormat = dateFormat
        }
        formatter.calendar = lunarCalendar
        return formatter.string(from: date)
    }
    
    //十二生肖年
    static public func zodiacsYear(withYear year: Int) -> String {
        let zodiacIndex: Int = (year - 1) % mStrArrZodiacs.count
        return mStrArrZodiacs[zodiacIndex]
    }
    
    static public func zodiacsYear(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return zodiacsYear(withYear: calendar.component(.year, from: date))
    }
    
    //计算日期年份的天干地支
    static func era(withYear year: Int) -> String {
        let heavenlyStemIndex: Int = (year - 1) % mStrArrHeavenlyStems.count
        let heavenlyStem: String = mStrArrHeavenlyStems[heavenlyStemIndex]
        let earthlyBrancheIndex: Int = (year - 1) % mStrArrEarthlyBranches.count
        let earthlyBranche: String = mStrArrEarthlyBranches[earthlyBrancheIndex]
        return heavenlyStem + earthlyBranche
    }
    
    static func era(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return era(withYear: calendar.component(.year, from: date))
    }
    
}
