//
//  Protocols.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation



//以下三个
//对应RouterCenter.register(url:String, handlerObject:RouterHandlerProtocol)
public protocol RouterHandlerProtocol {
    //普通数据通信，UIViewController通信，
    //RouterResponseProtocol.data可为UIViewController
    func handleRouter(url:String, parameters:[String:Any]?, completion:((RouterResponseProtocol) -> Void)?)
}

//对应RouterCenter.register(url:String, handlerClass:RouterStaticHandlerProtocol.Type)
public protocol RouterStaticHandlerProtocol { //可实现
    //普通数据通信，UIViewController通信，
    //RouterResponseProtocol.data可为UIViewController
    static func handleRouter(url:String, parameters:[String:Any]?, completion:((RouterResponseProtocol) -> Void)?)
}

//register(url:String, viewController:UIViewController.Type)中的UIViewController不一定需要实现该协议
//如果UIViewController需要将url和parameters作为init的初始化参数，则需要实现RouterViewControllerProtocol
//若未实现RouterViewControllerProtocol，则初始化UIViewController的时候只调用默认的init()
public protocol RouterViewControllerProtocol {
    
    init?(url:String,parameters:[String:Any]?);
}



