//
//  Obserable+mapObject.swift
//  Alonser
//
//  Created by yuxin on 2017/10/31.
//  Copyright © 2017年 Alonser. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya
import RxSwift

extension Observable {
    
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map({ (response) in
            guard let dict = response as? [String : Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return Mapper<T>().map(JSON: dict)!
        })
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map{ response in
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard let dicts = array as? [[String : Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }

