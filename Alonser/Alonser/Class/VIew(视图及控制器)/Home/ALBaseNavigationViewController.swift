//
//  ALBaseNavigationViewController.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import UIKit

class ALBaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

     @objc fileprivate func popView() {
        popViewController(animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if let vc = viewController as? ALBaseViewController {
            
            if childViewControllers.count > 0 {
            
                let title = ""
                
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(popView))
                
            }
        }
        
        super.pushViewController(viewController, animated: true)
    }

}
