//
//  BFEnum.swift
//  JiShanBuddhistFriends
//
//  Created by Hades on 2021/2/8.
//  Copyright © 2021 Simon. All rights reserved.
//

import Foundation

public enum MessageID:Int {
    case applicationWillEnterForeground = 0
    case applicationDidEnterBackground = 1
}
public enum NotificationKindKey : String{
    case DizangFastKey = "Dizang"
}
public enum EMineSwitchItem {
    enum switchBtn {
        case DizangFastRemind
        func value() -> String {
            switch self {
            case .DizangFastRemind: return "地藏斋，吃斋提醒"
            }
        }
    }
}
