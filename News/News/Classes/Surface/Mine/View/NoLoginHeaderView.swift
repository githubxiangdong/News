//
//  NoLoginHeaderView.swift
//  News
//
//  Created by 张向东 on 2020/1/14.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit
import SnapKit
import SwiftTheme

enum OnClickTag: Int {
    case tagPhoneClick = 10
    case tagWechatClick
    case tagQQClick
    case tagWeiboClick
    case tagMoreLogin
    case tagConcern
    case tagHistory
    case tagNight
}

class NoLoginHeaderView: UIView {
    
    lazy var bgImageView: UIImageView = {
       let bgImageView = UIImageView()
       bgImageView.image = UIImage(named: "wallpaper_profile_night")
       return bgImageView
    }()
    lazy var moreLoginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = OnClickTag.tagMoreLogin.rawValue
        btn.setTitle("更多登录方式 >", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.5)
        btn.layer.cornerRadius = 14
        btn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        btn.layer.theme_backgroundColor = "colors.moreLoginBgColor"
        btn.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        return btn
    }()
    var loginStackView: UIStackView!
    var otherView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 布局
extension NoLoginHeaderView {
    
    private func setUpUI() {
        self.addSubview(bgImageView)
        self.addSubview(moreLoginBtn)
        createThirdLogin()
        createOtherView()
    }
    
    private func addLayout() {
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(-20)
            make.right.left.bottom.equalTo(0)
        }
        
        loginStackView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(100)
        }
        
        moreLoginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginStackView.snp_bottom).offset(15)
            make.height.equalTo(28)
            make.width.equalTo(135)
            make.centerX.equalToSuperview()
        }
        
        otherView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(75)
        }
    }
    
    private func createThirdLogin() {
        let btn1 = createBtn("cellphoneicon_login_profile_66x66_", themePicker: "images.loginMoblieButton", OnClickTag.tagPhoneClick.rawValue)
        let btn2 = createBtn("weixinicon_login_profile_66x66_", themePicker: "images.loginWechatButton", OnClickTag.tagWechatClick.rawValue)
        let btn3 = createBtn("qqicon_login_profile_66x66_", themePicker: "images.loginQQButton", OnClickTag.tagQQClick.rawValue)
        let btn4 = createBtn("sinaicon_login_profile_66x66_", themePicker: "images.loginWeboButton", OnClickTag.tagWeiboClick.rawValue)
        
        loginStackView = UIStackView(arrangedSubviews: [btn1, btn2, btn3, btn4])
        loginStackView.distribution = UIStackView.Distribution.fillEqually
        self.addSubview(loginStackView)
    }
    
    private func createOtherView() {
        let btn1 = createBtn("favoriteicon_profile_24x24_", themePicker: "images.concernButton", OnClickTag.tagConcern.rawValue, "收藏")
        let btn2 = createBtn("history_profile_24x24_", themePicker: "images.historyButton", OnClickTag.tagHistory.rawValue, "历史")
        let btn3 = createBtn("nighticon_profile_24x24_", themePicker: "images.themeButton", OnClickTag.tagNight.rawValue, "夜间")
        let btnArr = [btn1, btn2, btn3]
        
        let btnW: CGFloat = ScreenWidth / 3
        let btnH: CGFloat = 75
        
        otherView = UIView()
        otherView.backgroundColor = UIColor.white
        otherView.theme_backgroundColor = "colors.cellBgColor"
        self.addSubview(otherView)
        for i in 0..<btnArr.count {
            let btnX = CGFloat(i) * btnW
            let frame = CGRect(x: btnX, y: 0, width: btnW, height: btnH)
            let btn = btnArr[i]
            btn.frame = frame
            otherView.addSubview(btn)
        }
    }
    
    private func createBtn(_ imageStr: String, themePicker: ThemeImagePicker? = nil, themeColor: ThemeCGColorPicker? = nil, _ tag: Int, _ title: String? = nil) -> (UIButton) {
        let btn = UIButton(type: .custom)
        btn.tag = tag
        btn.setImage(UIImage(named: imageStr), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        if let text = title {
            btn.imageEdgeInsets = UIEdgeInsets(top: -10, left: 20, bottom: 0, right: 0)
            btn.titleEdgeInsets = UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 30)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitle(text, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.theme_setTitleColor("colors.black", forState: .normal)
            if tag == OnClickTag.tagNight.rawValue {
                btn.setImage(UIImage(named: "dayicon_profile_night_24x24_"), for: .selected)
                btn.setTitle("日间", for: .selected)
                btn.isSelected = UserDefaults.standard.bool(forKey: isNight)
            }
        }
        
        if let theme = themePicker {
            btn.theme_setImage(theme, forState: .normal)
        }
        return btn
    }
}

/// 监听点击事件
extension NoLoginHeaderView {
    
    @objc func onClick(btn: UIButton) {
        
        let clickTag = OnClickTag(rawValue: btn.tag)
        switch clickTag {
        case .tagPhoneClick:
            print("tagPhoneClick")
        case .tagWechatClick:
            print("tagWechatClick")
        case .tagQQClick:
            print("tagQQClick")
        case .tagWeiboClick:
            print("tagWeiboClick")
        case .tagMoreLogin:
            print("tagMoreLogin")
        case .tagConcern:
            print("tagConcern")
        case .tagHistory:
            print("tagHistory")
        case .tagNight:
            print("tagNight")
            themeEvent(btn)
        case .none:
            print("none")
        }
    }
    
    private func themeEvent(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        UserDefaults.standard.set(btn.isSelected, forKey: isNight)
        MyTheme.switchNight(btn.isSelected)
        NotificationCenter.default.post(name: dayOrNightNotifation, object: btn.isSelected)
    }
}
