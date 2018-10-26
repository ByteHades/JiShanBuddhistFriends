//
//  BFDefine.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/23.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

//屏幕宽高
let Define_ScreenWidth = UIScreen.main.bounds.width
let Define_ScreenHeight = UIScreen.main.bounds.height

//是否为iPhone X
let Define_IsIphoneX =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

//是不是iOS7以后的操作系统
let Define_iOS7OrLater = ((NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) ? true : false)

// 导航栏高度
let Define_NavigationBarHeight:CGFloat = 44.0
// TabBar高度
let Define_TabBarHeight:CGFloat = (Define_IsIphoneX ? 83.0 : 49.0 )
// 状态栏高度
let Define_DistanceTop:CGFloat = ((Define_iOS7OrLater) ? UIApplication.shared.statusBarFrame.size.height :0)
// 状态栏+导航栏高度
let Define_NaviAddStatusHeight = Define_NavigationBarHeight + Define_DistanceTop
// 视图高度
let Define_ViewHeight = (Define_ScreenHeight - Define_DistanceTop - Define_NavigationBarHeight)
