//
// Created by soltan on 06/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

protocol AppColors {
    var primaryColor : UIColor { get }
    var primaryLightColor : UIColor { get }
    var primaryDarkColor : UIColor { get }
    var primaryTextColor : UIColor { get }
    var secondaryColor : UIColor { get }
    var secondaryLightColor : UIColor { get }
    var secondaryDarkColor : UIColor { get }
    var secondaryTextColor : UIColor { get }
}

protocol AppFonts {
    var mainFont : UIFont { get }
}

protocol AppStyle : class, AppColors, AppFonts {

}

class MainStyle : AppStyle {


    //MARK colors
    let primaryColor = UIColor(red: 0.88, green: 0.25, blue: 0.98, alpha: 1.0);
    let primaryLightColor = UIColor(red: 1.00, green: 0.47, blue: 1.00, alpha: 1.0);
    let primaryDarkColor = UIColor(red: 0.67, green: 0.00, blue: 0.78, alpha: 1.0);
    let primaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0);
    let secondaryColor = UIColor(red: 0.87, green: 0.17, blue: 0.00, alpha: 1.0);
    let secondaryLightColor = UIColor(red: 1.00, green: 0.39, blue: 0.20, alpha: 1.0);
    let secondaryDarkColor = UIColor(red: 0.64, green: 0.00, blue: 0.00, alpha: 1.0);
    let secondaryTextColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0);


    //MARK fonts
    let mainFont: UIFont = UIFont(name: "ChalkboardSE-Bold", size: UIFont.systemFontSize)!

}

class StyleManager {
    private init() {
        currentStyle = MainStyle()
    }
    static let shared = StyleManager()
    var currentStyle : AppStyle

}

extension UIColor  {
    static let primaryColor = StyleManager.shared.currentStyle.primaryColor;
    static let primaryLightColor = StyleManager.shared.currentStyle.primaryLightColor;
    static let primaryDarkColor = StyleManager.shared.currentStyle.primaryTextColor;
    static let primaryTextColor = StyleManager.shared.currentStyle.primaryTextColor;
    static let secondaryColor = StyleManager.shared.currentStyle.primaryTextColor;
    static let secondaryLightColor = StyleManager.shared.currentStyle.secondaryLightColor;
    static let secondaryDarkColor = StyleManager.shared.currentStyle.secondaryDarkColor;
    static let secondaryTextColor = StyleManager.shared.currentStyle.secondaryTextColor;
}
