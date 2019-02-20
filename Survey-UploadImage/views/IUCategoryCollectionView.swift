//
//  IUCategoryCollectionView.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

fileprivate let marginTop: CGFloat = 20
fileprivate let marginLeft: CGFloat = 10
fileprivate let lineSpacing: CGFloat = 10

fileprivate let itemW: CGFloat = itemH * 1.2
fileprivate let itemH: CGFloat = 120 - marginTop * 2

//header view height +  collection view height
fileprivate let defaultHeight: CGFloat = 120 + 60

class IUCategoryCollectionView: UIView {
    
    var headerView: IUCategoryHeaderView!
    var datasource: Array<IUImageObject>!
    var collectionView: UICollectionView!
    var imageCategory: ImageCategory
    
    init(category: ImageCategory, datasource: Array<IUImageObject>) {
        self.datasource = datasource
        self.imageCategory = category
        super.init(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: defaultHeight))
        
        //debug
        self.backgroundColor = UIColor.lightGray
        
        layoutHeaderView()
        initializeCollectionView()
    }
    
    //header view
    func layoutHeaderView() {
        self.headerView = IUCategoryHeaderView(imageCategory: self.imageCategory)
        self.addSubview(headerView)
    }
    
    func initializeCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: marginLeft, y: headerView.frame.size.height, width: SC_WIDTH - marginLeft * 2, height: itemH), collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "ImageUploadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageUploadCollectionViewCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        
//        collectionView.center.y = self.center.y
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(collectionView)
        
    }
    
//    func layoutView() {
//
//        //        self.backgroundColor = UIColor.lightGray
//
//        self.addSubview(collectionView)
//        collectionView.center.y = self.center.y
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
    
    func reloadData(datasource: Array<IUImageObject>) {
        self.datasource = datasource
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension IUCategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageUploadCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageUploadCollectionViewCell", for: indexPath) as! ImageUploadCollectionViewCell
        
        let imgObject = datasource[indexPath.item]
        cell.cellImageView.image = imgObject.originImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = CGSize(width: itemW, height: itemH)
        return size
    }
}

class IUCategoryHeaderView: UIView {
    var imageCategory: ImageCategory
    var deleteBtn: UIButton!
    
    init(imageCategory: ImageCategory) {
        self.imageCategory = imageCategory
        super.init(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: 60))
        layoutView()
    }
    
    func layoutView() {
        
        let padding: CGFloat = 16
        
        let titleLabel = UILabel(frame: CGRect(x: padding, y: 0, width: 200, height: 20))
        titleLabel.text = imageCategory.rawValue
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        titleLabel.textColor = UIColor(red: 95.0/255, green: 95.0/255, blue: 95.0/255, alpha: 1.0)
        titleLabel.center.y = self.center.y
        self.addSubview(titleLabel)
        
        let deleteBtn = UIButton(frame: CGRect(x: SC_WIDTH - (padding + 60), y: 0, width: 60, height: 20))
        deleteBtn.setTitle("Xóa", for: .normal)
        deleteBtn.backgroundColor = UIColor(red: 237.0/255, green: 237.0/255, blue: 237.0/255, alpha: 1.0)
        deleteBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        deleteBtn.titleLabel?.textColor = UIColor(red: 95.0/255, green: 95.0/255, blue: 95.0/255, alpha: 1.0)
        deleteBtn.layer.cornerRadius = 11
        deleteBtn.layer.masksToBounds = true
        deleteBtn.center.y = self.center.y
        self.addSubview(deleteBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
