//
//  MyTabBar.swift
//  News
//
//  Created by 张向东 on 2020/1/11.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabBarTintColor"
        theme_barTintColor = "colors.cellBgColor"
        addSubview(publishButton)
    }
    
    /*
     private 绝对私有，除了在当前类中可以访问之外，其他任何类或这个类的扩展都不能访问
     fileprivate 文件私有，可以在当前文件中访问，其他文件都不能访问
     internal 默认，可以不写，可以在当前模块中的任何文件中访问，其他模块不能访问
     pubilc 允许访问自己模块中源文件里的任何实体，允许别人通过引入该模块来访问源文件里的所有实体
     open 允许在定义实体的模块、其他模块中访问，允许其他模块进行继承、重写（open只能用在类、类成员上）
     */
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.theme_setBackgroundImage("images.feedPublishButton", forState: .normal)
        publishButton.theme_setBackgroundImage("images.feedPublishPressButton", forState: .selected)
        publishButton.sizeToFit() // 大小适应图片大小
        return publishButton
    }()
    
    // 必要初始化器
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 获取当前tabbar的高度
        let width = frame.width
        let height: CGFloat = 49
        
        publishButton.center = CGPoint(x: width / 2.0, y: height / 2.0 - 8)
        
        let buttonW: CGFloat = width / 5.0 // 5个按钮均分
        let buttonH: CGFloat = height
        let buttonY: CGFloat = 0.0
        
        var index = 0
        
        for button in subviews {
            if button.isKind(of: NSClassFromString("UITabBarButton")!) {
                let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
                index += 1
            }
        }
    }
}
