//
//  ViewController.swift
//  AnyRouter
//
//  Created by hushaohua8503 on 03/08/2021.
//  Copyright (c) 2021 hushaohua8503. All rights reserved.
//

import UIKit
import AnyRouter

public struct OtherModuleManager {
    public init() {
        
    }
    public func start() {
        RouterCenter.default.register(url: "as://native/as/:id", viewController: ASViewController.self)
    }
}

class ASViewController : UIViewController,RouterViewControllerProtocol {
    required init?(url: String, parameters: [String : Any]?) {
        guard let rawId = parameters?["id"] as? String else {
            return nil;
        }
        self.id = rawId;
        super.init(nibName: nil, bundle: nil)
        
    }
    
    var id:String
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "ASVC:\(self.id)"
    }
}

