//
//  ViewController.swift
//  AnyRouter
//
//  Created by hushaohua8503 on 03/08/2021.
//  Copyright (c) 2021 hushaohua8503. All rights reserved.
//

import UIKit
import AnyRouter

class TestRouterViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "TestRouterViewController"
    }
}

class TestRouterViewController2 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "TestRouterViewController2"
    }
}

class TestRouterViewController1 : UIViewController,RouterViewControllerProtocol {
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
        self.navigationItem.title = "TestRouterViewController1:\(self.id)"
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "ViewController"
    }
    @IBAction func testButtonClicked(_ sender: Any) {
        //UIViewController通用方法调用
//        AnyRouter.request(url: "https://testvc") {[weak self] (response) in
//            if let vc = response?.data as? UIViewController {
//                self?.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
        //UIViewController特定方法调用
//        if let vc = AnyRouter.viewController(url: "https://testvc") {
//            self.navigationController?.pushViewController(vc, animated: true);
//        }

        //有可变参数的路由
//        if let vc = AnyRouter.viewController(url: "https://testvc/12") {
//            self.navigationController?.pushViewController(vc, animated: true);
//        }
        
        //另一个模块中的路由
//        if let vc = AnyRouter.viewController(url: "as://native/as/12") {
//            self.navigationController?.pushViewController(vc, animated: true);
//        }
        
        //配置文件中的路由
        //https://testvc/test/:id
        if let vc = AnyRouter.viewController(url: "https://testvc/test/23") {
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

