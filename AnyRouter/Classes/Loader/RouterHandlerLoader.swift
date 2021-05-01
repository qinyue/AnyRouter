//
//  RouterCenter.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation


public struct RouterHandlerLoader {
    public static func loadFile(_ fileUrl:URL, from bundle:Bundle) {
        guard let data = try? Data(contentsOf: fileUrl) else {
            return;
        }
        guard let infos = try? PropertyListSerialization.propertyList(from: data, options: [.mutableContainers], format: nil), let dicts = infos as? [[String:String]] else {
            return;
        }
        let name = bundle.bundleURL.lastPathComponent.components(separatedBy: ".").first ?? ""
        for dict in dicts {
            guard let url = dict["url"], let handler = dict["handler"]  else {
                continue
            }
            
            var handlerClass: AnyClass? = bundle.classNamed(handler)
            if handlerClass == nil {
                handlerClass = bundle.classNamed(name + "." + handler)
            }
            if handlerClass != nil {
                if let vcClass = handlerClass! as? UIViewController.Type {
                    RouterCenter.default.register(url: url, viewController: vcClass)
                }else if let handlerType = handlerClass! as? RouterStaticHandlerProtocol.Type {
                    RouterCenter.default.register(url: url, handlerClass: handlerType)
                }
            }
            
        }
    }
}




