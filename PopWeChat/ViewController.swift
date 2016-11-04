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
        let button : UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 250,height: 44))
        button.center = self.view.center
        button.setTitle("弹出", for: UIControlState())
        button.setTitle("弹出", for: UIControlState.highlighted)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(ViewController.buttonDidCliked(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    func buttonDidCliked(_ button:UIButton){
        weak var weakself = self;
        self.bottomView = JKMMCustomBackView(frame: self.view.bounds,dataTitle: ["小绵羊","大灰狼","大绵羊","小灰狼"], title: "这里有一群小动物,可小可小了", cannle: "完成", cellDidCliked: { (text) -> Void in
             UIAlertView.init(title: "用户的选择", message: "用户选择了"+text, delegate: nil, cancelButtonTitle: "完成").show()
            weakself?.bottomView?.closeView()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

