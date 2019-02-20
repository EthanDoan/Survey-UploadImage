//
//  IUCollectionContainerView.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

fileprivate let marginTop: CGFloat = 20
fileprivate let marginLeft: CGFloat = 10
fileprivate let lineSpacing: CGFloat = 10

fileprivate let itemW: CGFloat = itemH * 1.2
fileprivate let itemH: CGFloat = 120 - marginTop * 2


class IUCollectionContainerView: UIView {

    var datasource: Array<Any>!
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(datasource: Array<Any>) {
        self.datasource = datasource
        super.init(frame: CGRect(x: 0, y: 0, width: SC_WIDTH, height: 120))
        initializeCollectionView()
        layoutView()
    }
    
    func initializeCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: marginLeft, y: 0, width: SC_WIDTH - marginLeft * 2, height: itemH), collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "ImageUploadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageUploadCollectionViewCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func layoutView() {
        
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(collectionView)
        collectionView.center.y = self.center.y
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension IUCollectionContainerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageUploadCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageUploadCollectionViewCell", for: indexPath) as! ImageUploadCollectionViewCell
        cell.cellImageView.image = UIImage(named: "sample.jpg")
        cell.cellImageView.contentMode = .scaleAspectFill
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

