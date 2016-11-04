//
//  JKMMCustomTableView.swift
//  NewWineClient
//
//  Created by 马少洋 on 16/3/10.
//  Copyright © 2016年 贵永冬. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class JKMMCustomTableView: UITableView ,UITableViewDelegate,UITableViewDataSource{

    //显示的列表
    var dataSourceArray:NSArray?
    //显示的列表标题
    var titleString : String?
    //显示取消按钮
    var cancelString : String?
    
    var cellNumber : NSInteger?
    fileprivate let titleCellHeight:CGFloat = 30
    fileprivate let dataCellHight:CGFloat = 40
    fileprivate let cancelCellHight:CGFloat = 50
    
    fileprivate var cellDidCliked:Closures?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.register(UITableViewCell.self, forCellReuseIdentifier:  "MSYIdentifier")
        self.backgroundColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /** 给cell赋 */
    func setCellValue(title:String?,dataCell:NSArray?,cancelString:String,cellDidCliked:@escaping Closures) -> Void {
        self.titleString = title
        self.dataSourceArray = dataCell
        if self.dataSourceArray != nil && self.dataSourceArray?.count > 0 {
            self.cellNumber = self.dataSourceArray?.count;
        }else{
            self.cellNumber = 0
        }
        self.cancelString = cancelString
        self.cellDidCliked = cellDidCliked
        self.reloadData();
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.titleString != nil {
            if(indexPath.row == 0){
                return self.createCellByTitleLabel()
            }else if(indexPath.row != (self.cellNumber)! + 1){
                return self.createCellByDataCellLabel(indexPath)
            }
        }else{
            if(indexPath.row != (self.cellNumber)!){
                return self.createCellByDataCellLabel(indexPath)
            }
        }
        return self.createBottomCancelButton(text: self.cancelString!)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.titleString != nil {
            if(indexPath.row == 0){
                return titleCellHeight
            }else if(indexPath.row !=  self.cellNumber! + 1 ){
                return dataCellHight
            }else{
                return cancelCellHight
            }
        }else{
            if(indexPath.row !=  self.cellNumber! ){
                return dataCellHight
            }else{
                return cancelCellHight
            }
        }


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.titleString == nil {
            return (self.cellNumber)! + 1
        }

        if(self.dataSourceArray != nil && self.cellNumber != 0){
            return (self.cellNumber)! + 2
        }
        return 2
    }

    /**
     返回标题的cell
     
     - returns: cell
     */
    func createCellByTitleLabel()->UITableViewCell{
        let cell : UITableViewCell = self.dequeueReusableCell(withIdentifier: "MSYIdentifier", for: IndexPath(row: 0, section: 0))
        var label:UILabel? = cell.contentView.viewWithTag(18) as? UILabel
        if(label == nil){
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1) , tag: 18, frame: CGRect(x: 0,y: 0 ,width: self.frame.size.width,height: self.titleCellHeight),fontSize:  14)
            cell.contentView.addSubview(label!)
            let line : UIView = self.createCellBottonLine(frame: CGRect(x: 0,y: self.titleCellHeight - 0.5 ,width: self.frame.size.width,height: 0.5))
            cell.contentView.addSubview(line)
        }
        label?.text = self.titleString
        return cell
    }
    /**
     返回数据的cell
     
     - parameter index: 第几个cell
     
     - returns: cell
     */
    func createCellByDataCellLabel(_ index:IndexPath)->UITableViewCell{

        var i = 0;
        if self.titleString == nil {
            i = 1
        }

        let cell : UITableViewCell = self.dequeueReusableCell(withIdentifier: "MSYIdentifier", for: IndexPath(row: 0, section: 0))
        var label:UILabel? = cell.contentView.viewWithTag(19) as? UILabel
        if(label == nil){
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1), tag: 19, frame: CGRect(x: 0,y: 0 ,width: self.frame.size.width,height: self.dataCellHight),fontSize: 15)
            cell.contentView.addSubview(label!)
            let line : UIView = self.createCellBottonLine(frame: CGRect(x: 0,y: self.dataCellHight - 0.5 ,width: self.frame.size.width,height: 0.5))
            cell.contentView.addSubview(line)
        }
        let obj : AnyObject? = self.dataSourceArray![index.row - 1 + i] as AnyObject?;
        if(obj is String){
            let text : String = (self.dataSourceArray![index.row - 1 + i] as? String)!
            label?.text = text
        }else{
            let text : NSMutableAttributedString = (self.dataSourceArray![index.row - 1] as? NSMutableAttributedString)!
            label?.attributedText = text
        }
        return cell
    }
    
    /**
    *  创建一个完成按钮
    */
    func createBottomCancelButton(text:String)->UITableViewCell{
        let cell : UITableViewCell = self.dequeueReusableCell(withIdentifier: "MSYIdentifier", for: IndexPath(row: 0, section: 0))
        var label:UILabel? = cell.contentView.viewWithTag(20) as? UILabel
        if(label == nil){
            let line : UIView = UIView(frame: CGRect(x: 0,y: 0,width: self.frame.size.width,height: 10))
            line.backgroundColor = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1)
            cell.addSubview(line)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(JKMMCustomTableView.bug))
            line.addGestureRecognizer(tap)
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1), tag: 20, frame: CGRect(x: 0,y: 10 ,width: self.frame.size.width,height: self.cancelCellHight - 10), fontSize:17)
            cell.contentView.addSubview(label!)
        }
        label?.text = self.cancelString
        return cell
    }

    /**
     工厂类创建label
     */
    func createLabelFactoryColor(color:UIColor,tag:NSInteger,frame:CGRect,fontSize:CGFloat)->UILabel{
        let label : UILabel = UILabel(frame: frame)
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.tag = tag
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.white
        label.isUserInteractionEnabled = true
        self.addGestureToView(label)
        return label
    }

    func bug() -> Void {
        if(self.cellDidCliked != nil){
            self.cellDidCliked!(self.cancelString!)
        }
    }
    /**
     添加手势给视图
    - parameter tap:
     */
    func addGestureToView(_ view:UIView){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JKMMCustomTableView.tapDidCliked(_:)))
        view.addGestureRecognizer(tap)

    }
    //标题呗点击
    func tapDidCliked(_ tap : UITapGestureRecognizer){
        let label : UILabel = tap.view as! UILabel
        if(self.cellDidCliked != nil){
            self.cellDidCliked!(label.text!)
        }
    }
    
    /**
     创建每个cell之间的分割线
     
     - parameter frame: frame
     
     - returns: view Line
     */
    func createCellBottonLine(frame:CGRect)-> UIView{
        let line : UIView = UIView(frame: frame)
        line.backgroundColor = UIColor(red: 210 / 255.0, green: 210 / 255.0, blue: 210 / 255.0, alpha: 1)
        return line
    }
   
}
