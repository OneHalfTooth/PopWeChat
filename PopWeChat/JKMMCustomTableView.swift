//
//  JKMMCustomTableView.swift
//  NewWineClient
//
//  Created by 马少洋 on 16/3/10.
//  Copyright © 2016年 马少洋. All rights reserved.
//

import UIKit

class JKMMCustomTableView: UITableView ,UITableViewDelegate,UITableViewDataSource{

    //显示的列表
    var dataSourceArray:NSArray?
    //显示的列表标题
    var titleString : String?
    //显示取消按钮
    var cancelString : String?
    
    private let titleCellHeight:CGFloat = 30
    private let dataCellHight:CGFloat = 40
    private let cancelCellHight:CGFloat = 50
    
    private var cellDidCliked:Closures?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.scrollEnabled = false
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier:  "MSYIdentifier")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //给cell赋值
    func setCellValue(title title : String,dataCell : NSArray,cancelString:String,cellDidCliked:Closures){
        self.titleString = title
        self.dataSourceArray = dataCell
        self.cancelString = cancelString
        self.cellDidCliked = cellDidCliked
        self.reloadData()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            return self.createCellByTitleLabel()
        }else if(indexPath.row != (self.dataSourceArray?.count)! + 1){
            return self.createCellByDataCellLabel(indexPath)
        }
        
        return self.createBottomCancelButton(text: self.titleString!)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return titleCellHeight
        }else if(indexPath.row != (self.dataSourceArray?.count)! + 1 ){
            return dataCellHight
        }else{
            return cancelCellHight
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.dataSourceArray == nil){
            return 0 
        }
       return (self.dataSourceArray?.count)! + 2
    }

    /**
     返回标题的cell
     
     - returns: cell
     */
    func createCellByTitleLabel()->UITableViewCell{
        let cell : UITableViewCell = self.dequeueReusableCellWithIdentifier("MSYIdentifier", forIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        var label:UILabel? = cell.contentView.viewWithTag(18) as? UILabel
        if(label == nil){
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1) , tag: 18, frame: CGRectMake(0,0 ,self.frame.size.width,self.titleCellHeight),fontSize:  14)
            cell.contentView.addSubview(label!)
            let line : UIView = self.createCellBottonLine(frame: CGRectMake(0,self.titleCellHeight - 0.5 ,self.frame.size.width,0.5))
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
    func createCellByDataCellLabel(index:NSIndexPath)->UITableViewCell{
        let cell : UITableViewCell = self.dequeueReusableCellWithIdentifier("MSYIdentifier", forIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        var label:UILabel? = cell.contentView.viewWithTag(19) as? UILabel
        if(label == nil){
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1), tag: 19, frame: CGRectMake(0,0 ,self.frame.size.width,self.dataCellHight),fontSize: 15)
            cell.contentView.addSubview(label!)
            let line : UIView = self.createCellBottonLine(frame: CGRectMake(0,self.dataCellHight - 0.5 ,self.frame.size.width,0.5))
            cell.contentView.addSubview(line)
        }
        let text : String = (self.dataSourceArray![index.row - 1] as? String)!
        label?.text = text
        return cell
    }
    
    /**
    *  创建一个完成按钮
    */
    func createBottomCancelButton(text text:String)->UITableViewCell{
        let cell : UITableViewCell = self.dequeueReusableCellWithIdentifier("MSYIdentifier", forIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        var label:UILabel? = cell.contentView.viewWithTag(20) as? UILabel
        if(label == nil){
            let line : UIView = UIView(frame: CGRectMake(0,0,self.frame.size.width,10))
            line.backgroundColor = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1)
            cell.addSubview(line)
            label = self.createLabelFactoryColor(color: UIColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1), tag: 20, frame: CGRectMake(0,10 ,self.frame.size.width,self.cancelCellHight - 10), fontSize:17)
            cell.contentView.addSubview(label!)
        }
        label?.text = self.cancelString
        return cell
    }

    /**
     工厂类创建label
     */
    func createLabelFactoryColor(color color:UIColor,tag:NSInteger,frame:CGRect,fontSize:CGFloat)->UILabel{
        let label : UILabel = UILabel(frame: frame)
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        label.tag = tag
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.whiteColor()
        label.userInteractionEnabled = true
        self.addGestureToView(label)
        return label
    }
    /**
     添加手势给视图
    - parameter tap:
     */
    func addGestureToView(view:UIView){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapDidCliked:"))
        view.addGestureRecognizer(tap)

    }
    //标题呗点击
    func tapDidCliked(tap : UITapGestureRecognizer){
        let label : UILabel = tap.view as! UILabel
        if(self.cellDidCliked != nil){
            self.cellDidCliked!(text: label.text!)
        }
    }
    
    /**
     创建每个cell之间的分割线
     
     - parameter frame: frame
     
     - returns: view Line
     */
    func createCellBottonLine(frame frame:CGRect)-> UIView{
        let line : UIView = UIView(frame: frame)
        line.backgroundColor = UIColor(red: 210 / 255.0, green: 210 / 255.0, blue: 210 / 255.0, alpha: 1)
        return line
    }
   
}
