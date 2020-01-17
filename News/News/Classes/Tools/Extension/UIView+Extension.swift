//
//  UIView+Extension.swift
//  News
//
//  Created by 张向东 on 2020/1/13.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib { }

extension RegisterCellOrNib {
    
    static var identifier: String {
        "\(self)" // cell的唯一标识符 用 自身的类表示
    }
    
    static var nib: UINib? {
        UINib(nibName: "\(self)", bundle: nil)
    }
}
