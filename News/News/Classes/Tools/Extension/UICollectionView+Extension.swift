//
//  UICollectionVIew+Extension.swift
//  News
//
//  Created by 张向东 on 2020/1/13.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // 注册cell的方法
    func zxd_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier) // xib注册
        }else {
            register(cell, forCellWithReuseIdentifier: T.identifier) // 代码注册
        }
    }
    
    // 从缓存池里取出已经存在 cell
    func zxd_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
