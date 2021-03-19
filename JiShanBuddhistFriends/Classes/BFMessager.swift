//
//  Messager.swift
//  JiShanBuddhistFriends
//
//  Created by Hades on 2021/2/8.
//  Copyright © 2021 Simon. All rights reserved.
//

import Foundation
/// 自定义消息分发类，为单例
/// 注意：添加侦听后，一定要移除
public final class BFMessager{
    
    private static var _Instance:BFMessager?
    
    public static var Instance:BFMessager!{
        get{
            if _Instance == nil {
                _Instance = BFMessager()
                return _Instance!
            }
            return _Instance!
        }
    }
    
    private init(){}
    
    
    /// key为事件名，value为元组(target: 对象, call: 方法)
    private var evts = Dictionary<MessageID,[(target:AnyObject?,call:(Any)->Void)]>()
    
    
    /// 添加侦听
    ///
    /// - Parameters:
    ///   - event: 事件名
    ///   - target: 对象
    ///   - callBack: 回调方法
    public func addListener(_ event:MessageID!,target:AnyObject?,callBack:@escaping (Any)->Void )
    {
        var list = evts[event]
        if list == nil {
            list = []
        }
        list?.append((target:target,call:callBack))
        evts[event] = list
    }
    
    
    /// 通过事件名删除侦听
    ///
    /// - Parameter event: 事件名
    public func removeListener(_ event:MessageID!)->Void
    {
        if evts[event] != nil
        {
            evts.removeValue(forKey: event)
        }
    }
    
    
    /// 通过事件名和对象移除侦听
    ///
    /// - Parameters:
    ///   - event: 事件名
    ///   - target: 对象
    public func removeListener(_ event:MessageID! , target: AnyObject? )
    {
        var list = evts[event]
        if list != nil {
            for (i,element) in list!.enumerated() {
                if target === element.target {
                    list?.remove(at: i)
                    if list?.count == 0 {
                        self.evts.removeValue(forKey: event)
                    }
                    break
                }
            }
        }
    }
    
    
    /// 抛出事件
    ///
    /// - Parameters:
    ///   - event: 事件名
    ///   - data: 数据
    public func dispatch(_ event:MessageID!, data:Any?)
    {
        let list = evts[event]
        if list != nil
        {
            for element in list! {
                element.call(data as Any)
            }
        }
    }
    
    
    /// 清除所有侦听
    public func clearAll()->Void{
        evts.removeAll()
    }
}
 
//测试
//Messager.shared.addListener("EVENT_OK",target:nil,callBack: { (data) in
//    print( data as! Int )
//})
////Messager.shared.addListener("EVENT_ERROR",target:nil,callBack: { (data) in
////    print("Error: \(data as! Int)" )
////})
//
//Messager.shared.dispatch("EVENT_OK", data: 3)
//Messager.shared.removeListener("EVENT_OK",target:nil)
//Messager.shared.dispatch("EVENT_OK", data: 3)
//Messager.shared.dispatch("EVENT_ERROR", data:5)


