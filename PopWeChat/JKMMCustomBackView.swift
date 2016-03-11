//
//  JKMMCustomBackView.swift
//
//  Created by 马少洋 on 16/3/10.
//  Copyright © 2016年马少洋. All rights reserved.
//

import UIKit


typealias Closures = (text : String)-> Void


class JKMMCustomBackView: UIView {

    private var tableView : JKMMCustomTableView?
    private let MSYWindowsWidth : CGFloat = UIScreen.mainScreen().bounds.size.width
    private let MSYWindowsHeight : CGFloat = UIScreen.mainScreen().bounds.size.height
    
    
    private let titleCellHeight:CGFloat = 30
    private let dataCellHight:CGFloat = 40
    private let cancelCellHight:CGFloat = 50
    
    private var tableViewHeight :CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
        self.createAction()
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    /**
     创建活动事件
     */
    func createAction(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("closeView"))
        self.addGestureRecognizer(tap)
    }
    
    /**
     创建背景视图，创建列表，
     
     - parameter dataTitle: 列表内容
     - parameter title:     内容的标题
     - parameter cannle:    返回按钮的辩题
     */
    func createCustomViewData(dataTitle dataTitle:NSArray,title:String,cannle:String,cellDidCliked:Closures){
        let temp : CGFloat = CGFloat(dataTitle.count)
        self.tableViewHeight = titleCellHeight + (temp * dataCellHight) + cancelCellHight
        self.tableView?.frame = CGRectMake(0,MSYWindowsHeight, MSYWindowsWidth, self.tableViewHeight!)
        self.tableView!.setCellValue(title: title, dataCell: dataTitle, cancelString: cannle, cellDidCliked: cellDidCliked)
    }
    
   //展开这个视图
    func showView(){
        let windows : UIWindow =  UIApplication.sharedApplication().keyWindow!
        windows .addSubview(self)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }) { (flag:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.tableView?.frame.origin = CGPointMake(0, self.MSYWindowsHeight - self.tableViewHeight!)
                })
        }
    }
    //关闭这个视图
    func closeView(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.tableView?.frame.origin = CGPointMake(0, self.MSYWindowsHeight)
            }) { (flag : Bool) -> Void in
                self.tableView?.removeFromSuperview();
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.removeFromSuperview()
                })
        }
    }
    
        /**
     创建视图
     */
    func createView(){
        self.tableView = JKMMCustomTableView(frame: CGRectMake(0, 0, MSYWindowsWidth, 0), style: UITableViewStyle.Plain)
        self.addSubview(self.tableView!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
