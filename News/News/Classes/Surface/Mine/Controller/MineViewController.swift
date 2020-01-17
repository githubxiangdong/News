//
//  MineViewController.swift
//  NewsDmeo
//
//  Created by 张向东 on 2020/1/10.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit
import SnapKit

let kHeaderViewHeight: CGFloat = 280 // 头部的高度

class MineViewController: UITableViewController {
    
    // 懒加载 实现 头部 view
    lazy var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kHeaderViewHeight - 20))
        return headerView
    }()
    lazy var sections = [[MyCellModel]]()
    lazy var concerns = [MyConcernModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.theme_backgroundColor = "colors.gloabBackgroudColor"
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.zxd_registerCell(cell: MineMainCell.self)
        tableView.zxd_registerCell(cell: MineAttentionCell.self)
        
        // 获取我的cell的数据
        // 思考下，下面闭包是否存在循环引用？？？？
        MineServe.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            
            // 我的关注数据
            MineServe.loadMyConcern { (concerns) in
                self.concerns = concerns
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
}

extension MineViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.zxd_dequeueReusableCell(indexPath: indexPath) as MineAttentionCell
            cell.selectionStyle = .none
            let section = sections[indexPath.section]
            cell.myCellModel = section[indexPath.row]
            
            if concerns.count == 0 || concerns.count == 1 {
                cell.attentionCollectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcernModel = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            return cell
        }
        let cell = tableView.zxd_dequeueReusableCell(indexPath: indexPath) as MineMainCell
        cell.selectionStyle = .none
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.titleLabel.text = myCellModel.text
        cell.messageLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offestY = scrollView.contentOffset.y
        if offestY < 0 {
            let totalOffest = kHeaderViewHeight + abs(offestY)
            let offest_r = totalOffest / kHeaderViewHeight
            headerView.bgImageView.snp.updateConstraints { (make) in
                make.left.equalTo(-ScreenWidth * (offest_r - 1))
                make.top.equalTo(offestY)
                make.right.equalTo(ScreenWidth * (offest_r - 1))
                make.height.equalTo(totalOffest)
            }
        }
    }
}
