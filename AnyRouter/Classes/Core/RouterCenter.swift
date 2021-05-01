//
//  RouterCenter.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation

class Node {
    
    var key:String
    var handlerObject:RouterHandlerProtocol?
    var handlerClass:RouterStaticHandlerProtocol.Type?
    var viewControllerClass:UIViewController.Type?
    var children:[Node]?
    var pathArgs:[PathArgumentItem]?
    init(key:String) {
        self.key = key;
    }
    
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

public class RouterCenter {
    
    public static let `default` = RouterCenter()
    
    lazy var nodes:[Node] = {
        return [Node]();
    }()
    
    public func register(url: String, handlerObject: RouterHandlerProtocol) {
        let node = register(url: url)
        node.handlerObject = handlerObject;
    }
    
    public func register(url: String, handlerClass: RouterStaticHandlerProtocol.Type) {
        let node = register(url: url)
        node.handlerClass = handlerClass
    }
    
    public func register(url:String, viewController:UIViewController.Type) {
        let node = register(url: url)
        node.viewControllerClass = viewController
    }
}

extension RouterCenter {
    func register(url:String) -> Node {
        if let urlComponents = URLComponents(string: url) {
            let scheme = urlComponents.scheme ?? ""
            let host = urlComponents.host ?? ""
            let path = urlComponents.path
            
            var schemeNode:Node?
            var hostNode:Node?
            var pathNode:Node?
            
            schemeNode = nodes.first { (node) -> Bool in
                return node.key == scheme;
            }
            if schemeNode == nil {
               schemeNode = Node(key: scheme)
                nodes.append(schemeNode!)
            }else {
                hostNode = schemeNode?.children?.first(where: { (node) -> Bool in
                    return node.key == host;
                })
            }
            
            if hostNode == nil {
                hostNode = Node(key: host)
                if schemeNode?.children == nil {
                    schemeNode!.children = [hostNode!]
                }else {
                    schemeNode!.children!.append(hostNode!)
                }
            }else {
                pathNode = hostNode?.children?.first(where: { (node) -> Bool in
                    return node.key == host;
                })
            }
            if pathNode == nil {
                pathNode = Node(key: path)
                if hostNode?.children == nil {
                    hostNode!.children = [pathNode!]
                }else {
                    hostNode!.children!.append(pathNode!)
                }
            }
            if let args = PathPatternManager.parse(path: path) {
                pathNode?.pathArgs = args;
            }
            
            return pathNode!
            
        }else {
            let obj = Node(key: url)
            self.nodes.append(obj)
            return obj;
        }
    }
    
    func matchedNode(url:String) -> (Node, [String:String]?)? {
        if let urlComponents = URLComponents(string: url) {
            let scheme = urlComponents.scheme ?? ""
            let host = urlComponents.host ?? ""
            let path = urlComponents.path
            
            let schemeNode = self.nodes.first { (node) -> Bool in
                return node.key == scheme;
            }
            guard schemeNode != nil else {
                return nil;
            }
            
            let hostNode = schemeNode!.children?.first { (tree) -> Bool in
                return tree.key == host;
            }
            guard hostNode != nil else {
                return nil;
            }
            
            let pathNode = hostNode!.children?.first { (tree) -> Bool in
                return tree.key == path;
            }
            if pathNode == nil {
                for node in hostNode!.children! {
                    if let params = PathPatternManager.checkPath(path, node: node) {
                        return (node, params)
                    }
                }
            }else {
                return (pathNode!, nil)
            }
            
        }else {
            if let node = self.nodes.first(where: { (tree) -> Bool in
                return tree.key == url;
            }) {
                return (node, nil)
            }
            return nil;
        }
        return nil;
    }
}

public enum RouterError: Error {
    case matchNone
    case noHandler
    case missParams
}

extension RouterCenter {
    public func startRequest(_ request:RouterRequestProtocol) {
        if let (node, pathParams) = RouterCenter.default.matchedNode(url: request.url) {
            var finalParams = [String:Any]()
            if pathParams != nil {
                finalParams += pathParams!
            }
            if request.parameters != nil {
                finalParams += request.parameters!
            }
            if node.handlerObject != nil {
                node.handlerObject?.handleRouter(url:request.url,parameters: finalParams, completion: request.responseClosure)
            }else if node.handlerClass != nil {
                node.handlerClass?.handleRouter(url:request.url,parameters: finalParams, completion: request.responseClosure)
            }else if node.viewControllerClass != nil {
                var vcObject:UIViewController?
                if let routerVCClass = node.viewControllerClass! as? RouterViewControllerProtocol.Type {
                    vcObject = routerVCClass.init(url: request.url, parameters: finalParams) as? UIViewController
                }else {
                    vcObject = node.viewControllerClass!.init()
                }
                if vcObject != nil {
                    let response = RouterResponse(data: vcObject!)
                    request.responseClosure?(response)
                }else {
                    request.responseClosure?(RouterResponse(error: RouterError.missParams))
                }
            }else {
                request.responseClosure?(RouterResponse(error: RouterError.noHandler))
            }
        }else {
            request.responseClosure?(RouterResponse(error: RouterError.matchNone))
        }
    }
    public func viewController(of request:RouterRequestProtocol) -> UIViewController?{
        if let (node, pathParams) = RouterCenter.default.matchedNode(url: request.url) {
            var finalParams = [String:Any]()
            if pathParams != nil {
                finalParams += pathParams!
            }
            if request.parameters != nil {
                finalParams += request.parameters!
            }
            if node.viewControllerClass != nil {
                var vcObject:UIViewController?
                if let routerVCClass = node.viewControllerClass! as? RouterViewControllerProtocol.Type {
                    vcObject = routerVCClass.init(url: request.url, parameters: finalParams) as? UIViewController
                }else {
                    vcObject = node.viewControllerClass!.init()
                }
                
                return vcObject;
            }
        }
        return nil;
    }
}

