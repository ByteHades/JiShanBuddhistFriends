//
//  BookContent.swift
//  JiShanBuddhistFriends
//  显示经书内容
//  Created by Simon on 2018/10/24.
//  Copyright © 2018 Simon. All rights reserved.
//

import Foundation
import UIKit

class BFBookInfoViewController: UIViewController, UITextViewDelegate {
    
    var textView = UITextView()
    
    var mBookInfoDic:NSDictionary?
    
    var mBtnReadFinish = UIButton()
    
    override func viewDidLoad() {
        self.InitView()
        self.ShowBook()
    }
    
    open func SetData(_bookInfoDic:NSDictionary) {
        mBookInfoDic = _bookInfoDic
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func InitView(){
        if mBookInfoDic == nil{
            return
        }
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = mBookInfoDic?.object(forKey: "Name") as? String
        textView = UITextView(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:Define_ScreenHeight - Define_NavigationBarHeight))
        
        self.view.addSubview(textView)
        //背景颜色设置
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor.black
        textView.isSelectable = false
        textView.isEditable = false
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.delegate = self
    }
    
    @objc func ReadFinish() {
//        textView.contentOffset = CGPoint(x: 0, y: -100)
        textView.setContentOffset(CGPoint(x: 0, y: -mBtnReadFinish.frame.height + 10), animated: true)
    }
    
    func ShowBook() {
        if mBookInfoDic == nil{
            return
        }
        
        //加载书籍文件
        textView.text = mBookInfoDic?.object(forKey: "Text") as? String
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0);
        textView.delaysContentTouches = false;
        
        //从新计算经文的长度，在经文的最低不添加一个按钮
        let frame = textView.frame
        let newSize = textView.sizeThatFits(CGSize(width: Define_ScreenWidth, height: CGFloat(MAXFLOAT)))
        textView.frame = frame
        
        mBtnReadFinish = UIButton(type: UIButton.ButtonType.system);
        mBtnReadFinish.frame = CGRect(x: 20, y: newSize.height, width:Define_ScreenWidth-40, height: 100)
        
        mBtnReadFinish.setTitle("念完", for: UIControl.State.normal)
        mBtnReadFinish.backgroundColor = UIColor.yellow
        mBtnReadFinish.addTarget(self, action: #selector(ReadFinish), for: UIControl.Event.touchUpInside)
        mBtnReadFinish.layer.cornerRadius = 10

        mBtnReadFinish.layer.masksToBounds = true
        
        textView.addSubview(mBtnReadFinish)
        
        textView.showsVerticalScrollIndicator = true;
    }
}
