//
//  BookContent.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/24.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

class BFBookInfoViewController: UIViewController {

    var textView = UITextView()
    var mBookInfoDic:NSDictionary?
    
    override func viewDidLoad() {
        self.InitView()
        self.ShowBook()
    }
    
    open func SetData(_bookInfoDic:NSDictionary) {
        mBookInfoDic = _bookInfoDic
    }
    
    func InitView(){
        if mBookInfoDic == nil{
            return
        }
        
        self.navigationItem.title = mBookInfoDic?.object(forKey: "Name") as? String
        textView = UITextView(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:Define_ScreenHeight))
        
        self.view.addSubview(textView)
        //背景颜色设置
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor.black
        textView.isSelectable = false
        textView.isEditable = false
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        textView.font = UIFont.systemFont(ofSize: 18)
        
    }
    
    func ShowBook() {
        if mBookInfoDic == nil{
            return
        }
        
        //加载书籍文件
        textView.text = mBookInfoDic?.object(forKey: "Text") as? String
        textView.contentInset = UIEdgeInsets(top: 0.1, left: 0, bottom: 0, right: 0);
    }
}
