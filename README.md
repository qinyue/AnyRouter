# AnyRouter
基于路由的模块间通信方案
[![CI Status](https://img.shields.io/travis/hushaohua8503/AnyRouter.svg?style=flat)](https://travis-ci.org/hushaohua8503/AnyRouter)
[![Version](https://img.shields.io/cocoapods/v/AnyRouter.svg?style=flat)](https://cocoapods.org/pods/AnyRouter)
[![License](https://img.shields.io/cocoapods/l/AnyRouter.svg?style=flat)](https://cocoapods.org/pods/AnyRouter)
[![Platform](https://img.shields.io/cocoapods/p/AnyRouter.svg?style=flat)](https://cocoapods.org/pods/AnyRouter)

## Example

```
RouterCenter.default.register(url: "https://m.baidu.com", handlerClass: ClassRouterHandler.self)
RouterCenter.default.register(url: "https://m.init.com", handlerObject: handler)
RouterCenter.default.register(url: "https://testvc", viewController: TestRouterViewController.self)
```
```
struct ObjectRouterHandler : RouterHandlerProtocol{
    func handleRouter(url: String, parameters: [String : Any]?, completion: ((RouterResponseProtocol) -> Void)?) {
        completion?(RouterResponse(data: "ObjectRouterHandler-success"))
    }
}

struct ClassRouterHandler : RouterStaticHandlerProtocol {
    static func handleRouter(url: String, parameters: [String : Any]?, completion: ((RouterResponseProtocol) -> Void)?) {
        completion?(RouterResponse(data: "ClassRouterHandler-success"))
    }
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AnyRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnyRouter'
```

## Author

hsh, qinyue0306@163.com

## License

AnyRouter is available under the MIT license. See the LICENSE file for more info.
