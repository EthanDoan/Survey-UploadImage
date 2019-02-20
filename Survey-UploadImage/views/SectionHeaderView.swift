//
//  SectionHeaderView.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class SectionHeaderView: UIView {
    let padding: CGFloat = 16
    var title: String
    var shotBtn:UIButton!
    
    override init(frame: CGRect) {
        title = ""
        super.init(frame: frame)
        layoutView()
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: 50))
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutView() {
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07)
        let titleLabel = UILabel(frame: CGRect(x: padding, y: 0, width: self.frame.size.width * 0.75, height: 18))
        titleLabel.center.y = self.center.y
        titleLabel.text = title
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        titleLabel.textColor = UIColor(red: 95.0/255, green: 95.0/255, blue: 95.0/255, alpha: 1.0)
        
        let btnWidth: CGFloat = 80
        shotBtn = UIButton(frame: CGRect(x:0, y: 0, width: btnWidth, height: 28))
        shotBtn.layer.cornerRadius = 6
        shotBtn.layer.masksToBounds = true
        shotBtn.setTitle("Chụp ảnh", for: .normal)
        shotBtn.setTitleColor(UIColor(red: 241.0/255, green: 116.0/255, blue: 35.0/255, alpha: 1.0), for: .normal)
        shotBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        shotBtn.backgroundColor = UIColor(red: 241.0/255, green: 116.0/255, blue: 35.0/255, alpha: 0.2)
        self.shotBtn?.frame.origin.x = self.frame.size.width - (padding + self.shotBtn!.frame.size.width)
        self.shotBtn?.center.y = self.center.y
        
        self.addSubview(titleLabel)
        self.addSubview(shotBtn)
    }
}
