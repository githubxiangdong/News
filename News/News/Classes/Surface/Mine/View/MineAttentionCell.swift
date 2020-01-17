//
//  MineAttentionCell.swift
//  News
//
//  Created by 张向东 on 2020/1/13.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

class MineAttentionCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attentionImageView: UIImageView!
    @IBOutlet weak var attentionCollectionView: UICollectionView!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var halvingline: UIView!
    
    var myConcerns = [MyConcernModel]() {
        didSet{
            attentionCollectionView.reloadData()
        }
    }
    var myCellModel: MyCellModel? {
        didSet {
            titleLabel.text = myCellModel?.text
        }
    }
    var myConcernModel: MyConcernModel? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attentionCollectionView.collectionViewLayout = MineAttentionFlowLayout()
        attentionCollectionView.delegate = self
        attentionCollectionView.dataSource = self
        attentionCollectionView.zxd_registerCell(cell: MineConcernCollectionCell.self)
        
        titleLabel.theme_textColor = "colors.black"
        nextImageView.theme_image = "images.cellRightArrow"
        halvingline.theme_backgroundColor = "colors.halvinglineColor"
        theme_backgroundColor = "colors.cellBgColor"
        topView.theme_backgroundColor = "colors.cellBgColor"
        attentionCollectionView.theme_backgroundColor = "colors.cellBgColor"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MineAttentionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.zxd_dequeueReusableCell(indexPath: indexPath) as MineConcernCollectionCell
        cell.myConcernModel = myConcerns[indexPath.row]
        return cell
    }
}

class MineAttentionFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        // 每个 cell 的大小
        itemSize = CGSize(width: 58, height: 74)
        // 横向间距
        minimumLineSpacing = 0
        // 纵向间距
        minimumInteritemSpacing = 0
        // cell 上下左右的间距
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 设置水平滚动
        scrollDirection = .horizontal
    }
}


