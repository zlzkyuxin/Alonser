//
//  ALMBPHud.swift
//  Alonser
//
//  Created by yuxin on 2017/11/1.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import UIKit

class ALMBPHud: UIView {
    //创建单例
    static let sharedInstance: ALMBPHud = {
        
        let instance = ALMBPHud()
        
        instance.backgroundColor = UIColor.clear
        
        return instance
    }()

    /// 动画显示
    func showLoadingOnView(view: UIView) {
        
        frame = UIScreen.main.bounds
        center = view.center
        
        let animation: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        animation.center = center
        
        let animationArray = [UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: ""),
                              UIImage.init(named: "")
                            ]
        animation.image = UIImage.animatedImage(with: animationArray as! [UIImage], duration: Double(animationArray.count) * 0.075)
        
        addSubview(animation)
        
        view.addSubview(self)
    }
    
    func showTips(title: String?) {
        //无数据直接返回
        guard let title = title else {
            return
        }
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = title
        
        //根据文字内容和大小计算size
        let size = title.boundingRect(with: CGSize.init(width: 200, height: 8000), options: [.truncatesLastVisibleLine, .usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: label.font], context: nil).size
        
        frame = CGRect.init(x: 0, y: 0, width: size.width + 20, height: size.height + 20)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        center = (window?.center)!
        
        //毛玻璃视图
        let blurEffect = UIBlurEffect.init(style: .dark)
        let effectView = UIVisualEffectView.init(effect: blurEffect)
        effectView.frame = bounds
        addSubview(effectView)
        
        label.textAlignment = .center
        label.frame = bounds
        addSubview(label)
        //隐藏视图
        let time = Double(title.characters.count) * 0.08
        UIView.animate(withDuration: time < 1.00 ? time : 1.00 , animations: {
            self.alpha = 0
        }) { (_) in
            self.hideTips()
        }
    }
    
    /// 隐藏
    func hideTips() {
        for view in subviews {
            
            view.removeFromSuperview()
            
        }
        
        alpha = 1
        
        removeFromSuperview()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
