//
//  ALNetworking.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import Foundation
import Alamofire
import Moya

private func JSONRequestDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

private func toolManager() -> Manager {
    
    let config = URLSessionConfiguration.default
    
    config.timeoutIntervalForRequest = 0
    
    let manager = Alamofire.SessionManager(configuration: config)
    
    manager.startRequestsImmediately = false
    
    return manager
}

let AlNetworkShared = MoyaProvider<ALNetworkShared>(manager: toolManager(), plugins: [NetworkLoggerPlugin.init(verbose: true, responseDataFormatter: JSONRequestDataFormatter)])


enum ALNetworkShared {
    case ALHTTPHeader(funId: String, parmas: [String : Any])
    case all
}

extension ALNetworkShared: TargetType {

    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "")!
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        return ""
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }

    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {
        return nil
    }

    public var parameters: [String: AnyObject] {

        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        let currentDateStr = dateFormatter.string(from: Date())

        let x = arc4random()%1000000000

        let requestId = String(format: "%@%d", currentDateStr,x)

        let mobileImei = ALUserIphoneInfo().identifierNumber!

        let md5Value = String(format: "%@%@ZOOMLIONAPP", requestId,mobileImei)

        var paramaters = ["channelNo" : "IOS_APP" as AnyObject,
                          "mobileImei" : mobileImei as AnyObject,
                          "requestId" : requestId as AnyObject,
                          "md5Value" : md5Value.md5String() as AnyObject,
                          "versionCode" : ALUserIphoneInfo().appversion! as AnyObject,
                          "versionName" : ALUserIphoneInfo().versionName! as AnyObject,
                          "deviceToken" : "asd" as AnyObject,
                          "clientType" : "APP_NORMAL" as AnyObject ,
                          "partnerNo" : "zoomlion" as AnyObject
        ]
        switch self {
        case .ALHTTPHeader(let funId, let parmas):
            paramaters["funId"] = funId as AnyObject
            paramaters["start"] = 1 as AnyObject
            paramaters["limit"] = 5 as AnyObject
            let keys = parmas.keys

            /// 拼接参数
            for key in keys {
                paramaters[key] = parmas[key] as AnyObject
            }

            return paramaters
        case .all:
            return [:]
        }

    }

}

