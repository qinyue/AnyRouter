//
//  RouterCenter.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation

public protocol RouterResponseProtocol {
    var error:Error?{get}
    var data:Any?{get}
}

public struct RouterResponse : RouterResponseProtocol {
    
    public var error: Error?
    public var data: Any?
    
    public init(data:Any) {
        self.data = data;
    }
    public init(error:Error) {
        self.error = error;
    }
}


//extension UIApplication {
//    func topViewController() -> UIViewController? {
//        return self.keyWindow?.rootViewController
//    }
//    func topNavigationController() -> UINavigationController? {
//        return self.topViewController() as? UINavigationController
//    }
//}
