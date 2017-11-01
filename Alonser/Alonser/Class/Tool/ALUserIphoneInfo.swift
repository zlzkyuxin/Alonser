//
//  ALUserIphoneInfo.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import UIKit

class ALUserIphoneInfo: NSObject {
    
    var infoDictionary:[String : AnyObject]? {
        return Bundle.main.infoDictionary as [String : AnyObject]?
    }
    
    var versionName: String? {
        return infoDictionary!["CFBundleExecutable"] as? String
    }
    
    var appDisplayName: String? {
        return infoDictionary!["CFBundleDisplayName"] as? String
    }
    
    var majorVersion: String? {
        return infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    var minorVersion: String? {
        return infoDictionary! ["CFBundleVersion"] as? String
    }
    
    var appversion: String? {
        return majorVersion
    }
    
    var identifierNumber: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }//设备 udid
    
    var systemName: String? {
        return UIDevice.current.systemName
    }//设备名称
    
    var model: String? {
        return UIDevice.current.model
    }//设备型号
    
    var localizedModel: String? {
        return UIDevice.current.localizedModel
    }//设备区域化型号 如 A1533
    
    var iosversion: String?{
        return UIDevice.current.systemVersion as String
    }//ios 版本
    
}
