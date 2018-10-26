//
//  FirstViewController.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/23.
//  Copyright © 2018 Simon. All rights reserved.
//

import UIKit

class BFBookViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    var cells : NSArray? // Global Variable
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func  numberOfSections(in tableView:UITableView) ->Int{
        return  (cells?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:"cellId", for: indexPath)
        
        if cell == nil{
            
            cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier:"cellId")
        }
        let row = cells?[indexPath.section] as? NSDictionary
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.text = row?.object(forKey: "Name") as? String
        cell.selectionStyle = UITableViewCell.SelectionStyle.blue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //处理点击事件
        tableView.deselectRow(at: indexPath, animated: true)
        let bookInfo = cells?[indexPath.section] as? NSDictionary
        if bookInfo != nil{
            let BookInfoVC = BFBookInfoViewController()
            BookInfoVC.SetData(_bookInfoDic: bookInfo!)
            self.navigationController?.pushViewController(BookInfoVC, animated: true)
        }
    }

    func  tableView(_ tableView:UITableView, heightForHeaderInSection section:Int) ->CGFloat{
        if section == 0 {
            return  0
            }
        return  50
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonPath = Bundle.main.path(forResource: "Book", ofType: "plist")
        cells = NSArray(contentsOfFile:jsonPath ?? "Book.plist")
        
        print(cells?.count ?? "0")
            
        // Do any additional setup after loading the view, typically from a nib.
        
        let  tableView = UITableView(frame:CGRect(x:0, y:40, width:self.view.frame.size.width, height:Define_ScreenHeight), style:UITableView.Style.plain)
        
        tableView.backgroundColor = UIColor.white
        
        tableView.dataSource=self
        
        tableView.delegate=self
        
        tableView.tableFooterView=UIView()
        
        self.view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cellId")
    }


}

