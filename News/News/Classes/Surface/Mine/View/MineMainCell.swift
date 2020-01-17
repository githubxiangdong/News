//
//  MineMainCell.swift
//  News
//
//  Created by 张向东 on 2020/1/12.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

class MineMainCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var halvingline: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.theme_textColor = "colors.black"
        nextImageView.theme_image = "images.cellRightArrow"
        halvingline.theme_backgroundColor = "colors.halvinglineColor"
        theme_backgroundColor = "colors.cellBgColor"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
