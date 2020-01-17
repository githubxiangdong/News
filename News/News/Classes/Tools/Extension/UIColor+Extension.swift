//
//  UIColor+Extension.swift
//  News
//
//  Created by 张向东 on 2020/1/11.
//  Copyright © 2020 张向东. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 便捷初始化器必须要调用一个指定初始化器，并且要在最开始调用
    // 设置一个默认值参数 alpha: CGFloat = 1
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        if #available(iOS 10.0, *) {
            // displayP3Red 效率更高
            self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        } else {
            self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        }
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
     
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    // 类方法实现全局背景色
    /*
     类方法既可以用class修饰，也可以用static修饰
     如果父类的类方法使用static修饰的话，子类不能重写这个类方法；
     如果父类的类方法使用class修饰的话，子类能够重写这个类方法。
     如果父类的类方法是使用final class修饰的话，子类不能重写这个类方法。
     综上，static自带final class的性质。
     你希望子类能够重写其父类的某个类方法，那就使用class修饰这个类方法。
     你不希望子类能够重写其父类的某个类方法，那就使用static修饰这个类方法
     */
    class func globalBackgroundColor() -> UIColor {
        let color: UIColor!
        if UserDefaults.standard.bool(forKey: isNight) {
            color = UIColor(hexString: "#f6f6f6")
        }else {
            color = UIColor(hexString: "#1b1b1b")
        }
        return color
    }
}
