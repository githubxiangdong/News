//
//  MyTableController.swift
//  NewsDmeo
//
//  Created by 张向东 on 2020/1/10.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit
import SwiftTheme

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 添加子控制器
        addChildViewControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(onDayOrNightNotification), name: dayOrNightNotifation, object: nil)
        
        print("code")
    }
    
    private func addChildViewControllers() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video")
        setChildViewController(HuoShanViewController(), title: "小视频", imageName: "huoshan")
        setChildViewController(MineViewController(), title: "未登录", imageName: "no_login")
        // tabBar 是 readonly属性，不能直接修改，利用kvc修改
        setValue(MyTabBar(), forKey: "tabBar") // 如何找到这个key???
    }
    
    private func setChildViewController(_ childViewController: UIViewController, title: String, imageName: String) {
        // 设置tabBar 的文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildViewController(childViewController, title: title, imageName: imageName)
        }else {
            setDayChildViewController(childViewController, title: title, imageName: imageName)
        }
        childViewController.title = title;
        let navVc = MyNavigationController(rootViewController: childViewController)
        addChild(navVc)
    }
    
    /// 设置夜间控制器
    func setNightChildViewController(_ childViewController: UIViewController, title: String, imageName: String) {
        childViewController.tabBarController?.view.theme_backgroundColor = "colors.gloabBackgroudColor"
        childViewController.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        childViewController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    /// 设置日间控制器
    func setDayChildViewController(_ childViewController: UIViewController, title: String, imageName: String) {
        childViewController.tabBarController?.view.theme_backgroundColor = "colors.gloabBackgroudColor"
        childViewController.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        childViewController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
}

extension MyTabBarController {
    
    @objc func onDayOrNightNotification(_ notification: Notification) {
        
        if let selected = notification.object as? Bool {
            if selected { // true 设置为夜间
                for child in children {
                    switch child.title! {
                    case "首页":
                        setNightChildViewController(child, title: child.title!, imageName: "home")
                    case "视频":
                        setNightChildViewController(child, title: child.title!, imageName: "video")
                    case "小视频":
                        setNightChildViewController(child, title: child.title!, imageName: "huoshan")
                    case "未登录":
                        setNightChildViewController(child, title: child.title!, imageName: "no_login")
                    default:
                        break
                    }
                }
            }else { // 设置为日间
                for child in children {
                    switch child.title! {
                    case "首页":
                        setDayChildViewController(child, title: child.title!, imageName: "home")
                    case "视频":
                        setDayChildViewController(child, title: child.title!, imageName: "video")
                    case "小视频":
                        setDayChildViewController(child, title: child.title!, imageName: "huoshan")
                    case "未登录":
                        setDayChildViewController(child, title: child.title!, imageName: "no_login")
                    default:
                        break
                    }
                }
            }
        }
    }
}
