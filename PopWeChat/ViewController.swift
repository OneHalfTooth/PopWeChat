//
//  ViewController.swift
//  微信弹出
//
//  Created by 马少洋 on 16/3/11.
//  Copyright © 2016年 马少洋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bottomView:JKMMCustomBackView?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.createView()
      
    }
    func createView(){
        self.createButton()
    }
    func createButton(){
        let button : UIButton = UIButton(frame: CGRectMake(0,0,250,44))
        button.center = self.view.center
        button.setTitle("弹出", forState: UIControlState.Normal)
        button.setTitle("弹出", forState: UIControlState.Highlighted)
        button.tag = 111
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: Selector("buttonDidCliked:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    func buttonDidCliked(button:UIButton){
        self.bottomView = JKMMCustomBackView(frame: self.view.bounds)
//        self.bottomView?.createCustomViewData(dataTitle: ["😊","😢","🔋","🐑"], title: "不是吧", cannle: "完成", cellDidCliked: { (text) -> Void in
//            print("选择了\(text)")
//            self.bottomView?.closeView()
//        })

        self.bottomView?.createCustomViewData(dataTitle: ["😊","😢","🔋","🐑"], title: nil, cannle: "完成", cellDidCliked: { (text) -> Void in
            print("选择了\(text)")
            self.bottomView?.closeView()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

