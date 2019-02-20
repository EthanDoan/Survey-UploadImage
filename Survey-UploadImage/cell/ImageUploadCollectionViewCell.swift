//
//  ImageUploadCollectionViewCell.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ImageUploadCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    var imageObject: IUImageObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCell(imageObject: IUImageObject) {
        self.cellImageView.image = imageObject.originImage
    }

}
