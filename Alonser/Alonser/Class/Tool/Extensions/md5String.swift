//
//  md5String.swift
//  Swift_Equipment
//
//  Created by yuxin on 2017/10/23.
//  Copyright © 2017年 lala. All rights reserved.
//

import Foundation

extension String
{
    func md5String() -> String
    {
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)

        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        
        let str = (md5String as String).uppercased()
        
        return str
    }
}
