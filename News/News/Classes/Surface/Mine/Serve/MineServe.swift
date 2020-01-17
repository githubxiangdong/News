//
//  MineServe.swift
//  News
//
//  Created by 张向东 on 2020/1/12.
//  Copyright © 2020 张向东. All rights reserved.
//

import Foundation

protocol MineServeProtocol {
    
    // 我的界面 cell 的数据
    static func loadMyCellData(finish: @escaping (_ sections: [[MyCellModel]]) -> ())
    // 我的关注数据
    static func loadMyConcern(finsh: @escaping (_ concerns: [MyConcernModel]) -> ())
}

// 实现这个协议
extension MineServeProtocol {
    
    // 我的界面 cell 的数据
    static func loadMyCellData(finish: @escaping (_ sections: [[MyCellModel]]) -> ()) {
        
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id" : device_id]
        NetworkTool.myRequest(url, parameters: params) { (result) in
            
            guard let resultDic = result as? NSDictionary else { return }
            guard let message = resultDic["message"] as? String else { return }
            guard message == "success" else { return }
            guard let dataDic = resultDic["data"] as? NSDictionary else { return }
            guard let sections = dataDic["sections"] as? NSArray else { return }
            
            var sectionArrary = [[MyCellModel]]()
            for item in sections {
                var rows = [MyCellModel]()
                guard let items = item as? NSArray else { return }
                for row in items {
                    let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                    rows.append(myCellModel!)
                }
                sectionArrary.append(rows)
            }
            finish(sectionArrary)
        }
    }
    
    // 我的关注数据
    static func loadMyConcern(finsh: @escaping (_ concerns: [MyConcernModel]) -> ()) {
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id" : device_id]
        NetworkTool.myRequest(url, parameters: params) { (result) in
            
            guard let resultDic = result as? NSDictionary else { return }
            guard let message = resultDic["message"] as? String else { return }
            guard message == "success" else { return }
            guard let datas = resultDic["data"] as? NSArray else { return }
            
            var concernsArr = [MyConcernModel]()
            for item in datas {
                let concernModel = MyConcernModel.deserialize(from: item as? NSDictionary)
                concernsArr.append(concernModel!)
            }
            finsh(concernsArr)
        }
    }
}

struct MineServe: MineServeProtocol { }
