//
//  RouterCenter.swift
//  Pods
//
//  Created by shaohua Hu on 2021/3/8.
//

import Foundation

struct PathArgumentItem {
    var index:Int
    var fixedString:String
    
    var key:String?
    init(index:Int, fixed:String) {
        self.index = index
        self.fixedString = fixed;
    }
}

struct PathPatternManager {
//    let pathExpression:NSRegularExpression? = try? NSRegularExpression(pattern: "\\([a-zA-Z0-9]+\\)", options: .caseInsensitive)
//    let pathExpression:NSRegularExpression? = try? NSRegularExpression(pattern: "\\:[a-zA-Z0-9]+", options: .caseInsensitive)
    
    static func parse(path:String) -> [PathArgumentItem]?{
        if (!path.contains(":")) {
            return nil;
        }
        let pathSegments = path.components(separatedBy: "/")
        var argItems = [PathArgumentItem]()
        for segmentIndex in 0..<pathSegments.count {
            let segment = pathSegments[segmentIndex]
            if let index = segment.firstIndex(of: ":") {
                let next = segment.index(index, offsetBy: 1)
                let key = segment[next...];
                let prefix = String(segment[..<index]);
                var item = PathArgumentItem(index: segmentIndex, fixed: prefix)
                item.key = String(key);
                argItems.append(item)
            }else {
                argItems.append(PathArgumentItem(index: segmentIndex, fixed: segment))
            }
        }
        
        return argItems.count > 0 ? argItems : nil;
    }
    
    static func checkPath(_ path:String, node:Node) -> [String:String]? {
        guard let argItems = node.pathArgs else {
            return nil
        }
        let pathSegments = path.components(separatedBy: "/")
        if (argItems.count != pathSegments.count) {
            return nil;
        }
        var pathArgDict = [String:String]()
        for index in 0..<pathSegments.count {
            let argItem = argItems[index]
            let pathSegment = pathSegments[index]
            if argItem.key == nil {
                if pathSegment != argItem.fixedString {
                    return nil;
                }
            }else{
                if argItem.fixedString.isEmpty {
                    pathArgDict[argItem.key!] = pathSegment
                }else if let range = pathSegment.range(of: argItem.fixedString), range.lowerBound.encodedOffset == 0 {
                    let value = pathSegment[range.upperBound...];
                    pathArgDict[argItem.key!] = String(value)
                }else {
                    return nil;
                }
            }
        }
        return pathArgDict;
    }
}




