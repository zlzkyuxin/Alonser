//
//  ALBaseViewController.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import UIKit

typealias finshAinshClosure = () -> Void

class ALBaseViewController: UIViewController {
    // Reachability必须一直存在，所以需要设置为全局变量
    let reachability = Reachability()!
    
    var finshClosure: finshAinshClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        NetworkStatusListener()
     
        self.initView()
    }
    
    func initView() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.finshClosure != nil {
                self.view.backgroundColor = UIColor.green
                self.finshClosure!()
            }
        }
    }

}

// MARK: - 监听网络状态
extension ALBaseViewController {
    fileprivate func NetworkStatusListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("start reachability notifier failer!")
        }
    }
    
    /// 检测网络状态
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable { //网络连接状态
            
            if reachability.isReachableViaWiFi {//wifi
                ALlogger.debug("WIFI")
            } else {//移动网络
                ALlogger.debug("移动网络")
            }
            
        } else {//网络不可用
            ALlogger.debug("网络不可用")
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "系统提示", message: "请打开网络连接", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}




















