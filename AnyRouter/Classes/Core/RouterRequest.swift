//
//  RouterCenter.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation

public protocol RouterRequestProtocol {
    var url:String {get}
    var parameters:[String:Any]?{get}
    var responseClosure:((RouterResponseProtocol) -> Void)? {get}
}

public struct SimpleRouterRequest : RouterRequestProtocol {
    
    public var url: String
    public var parameters:[String:Any]?
    public var responseClosure: ((RouterResponseProtocol) -> Void)?
    public init(url:String) {
        self.url = url
    }
}

public func request(url:String, parameters:[String:Any]?=nil, completion:((RouterResponseProtocol?) -> Void)?) {
    var request = SimpleRouterRequest(url: url)
    request.parameters = parameters
    request.responseClosure = completion;
    RouterCenter.default.startRequest(request)
}

public func viewController(url:String, parameters:[String:Any]?=nil) -> UIViewController? {
    var request = SimpleRouterRequest(url: url)
    request.parameters = parameters
    return RouterCenter.default.viewController(of: request)
}
