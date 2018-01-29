//
//  ALLoginViewController.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import UIKit
import SnapKit

class ALLoginViewController: UIViewController {

    lazy var centerView1 = UIView()
    lazy var centerView2 = UIView()
    
    var sizeConstraaint: Constraint?
    
    var place = 1.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //界面初始化
        self.initView()
        
//        UIView.animate(withDuration: 10) {
            for i in 0..<10 {
                self.place += 0.1
                //告诉页面需要更新约束
                self.view.setNeedsUpdateConstraints()
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 界面初始化
    fileprivate func initView() {
        self.view.backgroundColor = UIColor.red
        
        centerView1.backgroundColor = UIColor.green
        view.addSubview(centerView1)
        centerView2.backgroundColor = UIColor.blue
        view.addSubview(centerView2)
        
        centerView1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100 * self.place).priority(250)
            
            //最大尺寸不能超过屏幕
            make.width.height.lessThanOrEqualTo(self.view.snp.width)
            make.width.height.lessThanOrEqualTo(self.view.snp.height)
        }

        
        
        
    }

    override func updateViewConstraints() {
        self.centerView1.snp.updateConstraints { (make) in
            make.width.height.equalTo(100 * self.place).priority(250)
            
        }
        super.updateViewConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.place += 0.1
        //告诉页面需要更新约束
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
       
    }
}
