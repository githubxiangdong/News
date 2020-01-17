//
//  MineConcernCollectionCell.swift
//  News
//
//  Created by 张向东 on 2020/1/13.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit
import Kingfisher

class MineConcernCollectionCell: UICollectionViewCell, RegisterCellOrNib{
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// vip标
    @IBOutlet weak var vipImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 消息通知
    @IBOutlet weak var tipsView: UIView!
    
    var myConcernModel: MyConcernModel? {
        didSet {
            if let iconStr = myConcernModel?.icon { // 可选链取出的东西有可能是空的
                avatarImageView.kf.setImage(with: URL(string: iconStr))
            }
            if let is_verify = myConcernModel?.is_verify {
                vipImageView.isHidden = !is_verify
            }
            if let tips = myConcernModel?.tips {
                tipsView.isHidden = !tips
            }
            nameLabel.text = myConcernModel?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tipsView.layer.borderWidth = 1
        tipsView.layer.borderColor = UIColor.white.cgColor
        
        theme_backgroundColor = "colors.cellBgColor"
        nameLabel.theme_textColor = "colors.black"
    }
}
