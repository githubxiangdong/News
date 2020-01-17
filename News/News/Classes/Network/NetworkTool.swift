//
//  NetworkTool.swift
//  News
//
//  Created by 张向东 on 2020/1/11.
//  Copyright © 2020 张向东. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTool {
    
    // 类方法
    class func myRequest(_ url: String, methodType: MethodType = .get, parameters: [String : Any]? = nil, finishCallback: @escaping (_ result: Any) -> ()) {
        
        // 获取请求类型
         let method = methodType == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 发送网络请求
         Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            
            // 获取结果
             guard let result = response.result.value else {
                 print(response.result.error!)
                 return
             }
            
            // 将结果回调出去
             finishCallback(result)
         }
     }
}

