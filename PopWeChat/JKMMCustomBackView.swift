//
//  JKMMCustomBackView.swift
//
//  Created by 马少洋 on 16/3/10.
//  Copyright © 2016年马少洋. All rights reserved.
//

import UIKit


typealias Closures = (String)-> Void


class JKMMCustomBackView: UIView {

    fileprivate var tableView : JKMMCustomTableView?
    fileprivate let MSYWindowsWidth : CGFloat = UIScreen.main.bounds.size.width
    fileprivate let MSYWindowsHeight : CGFloat = UIScreen.main.bounds.size.height
    
    
    fileprivate let titleCellHeight:CGFloat = 30
    fileprivate let dataCellHight:CGFloat = 40
    fileprivate let cancelCellHight:CGFloat = 50
    
    fileprivate var tableViewHeight :CGFloat?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.createView()
        self.createAction()
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    convenience init(frame:CGRect,dataTitle:NSArray,title:String?,cannle:String,cellDidCliked:@escaping Closures) {
        self.init(frame:frame)
        self.createCustomViewData(dataTitle:dataTitle,title: title,cannle:cannle,cellDidCliked:cellDidCliked)
    }
    
    /**
     创建活动事件
     */
    fileprivate func createAction(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JKMMCustomBackView.closeView))
        self.addGestureRecognizer(tap)
    }
    /**
     创建背景视图，创建列表，
     
     - parameter dataTitle: 列表内容
     - parameter title:     内容的标题
     - parameter cannle:    返回按钮的辩题
     */
    fileprivate func createCustomViewData(dataTitle:NSArray,title:String?,cannle:String,cellDidCliked:@escaping Closures) -> Void {
        let temp: CGFloat = CGFloat(dataTitle.count)
        if title == nil {
            self.tableViewHeight = (temp * dataCellHight) + cancelCellHight
        }else{
            self.tableViewHeight = titleCellHeight + (temp * dataCellHight) + cancelCellHight
        }
        self.tableView?.frame = CGRect(x: 0,y: MSYWindowsHeight, width: MSYWindowsWidth, height: self.tableViewHeight!)
        self.tableView!.setCellValue(title: title, dataCell: dataTitle, cancelString: cannle, cellDidCliked: cellDidCliked)
        self.showView()
    }
    
    
   //展开这个视图
    fileprivate func showView(){
        let windows : UIWindow =  UIApplication.shared.keyWindow!
        windows .addSubview(self)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }, completion: { (flag:Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.tableView?.frame.origin = CGPoint(x: 0, y: self.MSYWindowsHeight - self.tableViewHeight!)
                })
        }) 
    }
    //关闭这个视图
    func closeView(){
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.tableView?.frame.origin = CGPoint(x: 0, y: self.MSYWindowsHeight)
            }, completion: { (flag : Bool) -> Void in
                self.tableView?.removeFromSuperview();
                self.tableView = nil
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.removeFromSuperview()

                })
        }) 
    }
    
        /**
     创建视图
     */
    fileprivate func createView(){
        self.tableView = JKMMCustomTableView(frame: CGRect(x: 0, y: 0, width: MSYWindowsWidth, height: 0), style: UITableViewStyle.plain)
        self.addSubview(self.tableView!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
