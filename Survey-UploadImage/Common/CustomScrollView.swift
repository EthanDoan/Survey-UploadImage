//
//  CustomScrollView.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 9/15/18.
//  Copyright © 2018 Dylan Bui. All rights reserved.
//

import UIKit

func isIphone() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
}

func IS_IPHONE_X() -> Bool {
    return (isIphone() && SCREEN_MAX_LENGTH() == 812)
}

func SCREEN_MAX_LENGTH() -> Int {
    return Int(max(SC_WIDTH, SC_HEIGHT))
}

class CustomScrollView: UIScrollView {

    var views: Array<UIView>
    var sumHeight: CGFloat = 0
    
    var additionContentHeight: CGFloat {
        return IS_IPHONE_X() == true ? 32 : 0
    }
    
    init(views: Array<UIView>) {
        self.views = views
        super.init(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: SC_HEIGHT))
        self.backgroundColor = UIColor.clear
        self.bounces = true
        self.alwaysBounceVertical = true
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        for view in self.views {
            view.frame.origin.y = sumHeight
            self.addSubview(view)
            sumHeight += view.frame.size.height
        }
        
//        var bottomPadding: CGFloat = 0.0
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.keyWindow
//            bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
//        }
//
//        self.contentSize = CGSize(width: self.frame.size.width, height: sumHeight + additionContentHeight)
        
        self.contentSize = CGSize(width: self.frame.size.width, height: sumHeight + safeAreaInsetBottom() - 2)
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func relayout() {
        sumHeight = 0
        for view in self.views {
            view.frame.origin.y = sumHeight
            sumHeight += view.frame.size.height
        }
        self.contentSize = CGSize(width: self.frame.size.width, height: sumHeight + safeAreaInsetBottom())
    }

    func safeAreaInsetBottom() -> CGFloat {
        var bottomPadding: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        }
        return bottomPadding
    }
    
    func addBottomPadding(_ height: CGFloat) {
        let bottomPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: height))
        views.append(bottomPaddingView)
        relayout()
    }
}
