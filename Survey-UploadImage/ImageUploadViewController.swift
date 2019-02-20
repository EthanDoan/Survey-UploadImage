//
//  ImageUploadViewController.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import RSSelectionMenu

let SC_WIDTH = UIScreen.main.bounds.size.width
let SC_HEIGHT = UIScreen.main.bounds.size.height

class ImageUploadViewController: UIViewController {

    var scrollView: CustomScrollView?
    
    //tong quan header view
    var generalview: SectionHeaderView!
    
    //phan loai header view
    var otherView: SectionHeaderView!
    
    //collection view for TONG_QUAN
    var collectionContainerView: IUCollectionContainerView!
    
    //datasource for TONG_QUAN collection view
    var datasource: Array<IUImageObject>!
    
    //Dictionary chua cac tap hinh anh phan loai theo category
    //Su dung ImageCategory.rawValue lam key
    var otherDictionary = [String : Array<IUImageObject>]()
    
    var imagePicker: UIImagePickerController!
    var imageCategory: ImageCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        datasource = Array<IUImageObject>()
        
        //1. header view 1
        generalview = SectionHeaderView(title: "Hình tổng quan")
        generalview.shotBtn.addTarget(self, action: #selector(ImageUploadViewController.shotBtnTapped), for: .touchUpInside)
        
        //2. collection view tong quan
        collectionContainerView = IUCollectionContainerView(datasource: datasource)
        
        //3. header view 2
        otherView = SectionHeaderView(title: "Ưu điểm và nhược điểm")
        otherView.shotBtn.addTarget(self, action: #selector(ImageUploadViewController.otherCategoryBtnTapped), for: .touchUpInside)
        
        //4. collection view load from Dictionary
        
        
        scrollView = CustomScrollView(views: [generalview, collectionContainerView, otherView])
        self.view.addSubview(scrollView!)
        
    }
    
    @objc func shotBtnTapped() {
        imageCategory = .TONG_QUAN
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func otherCategoryBtnTapped() {
        
        // show list of category
        let sourceArr = ["TONG_QUAN","COT_DIEN_TRAM_BIEN_AP","HO_GA","LUOI_DIEN_CAO_THE"]
        let selectionMenu = RSSelectionMenu(dataSource: sourceArr) { (cell, item, indexPath) in
            cell.textLabel?.text = item
        }
        
        selectionMenu.onDismiss = { selectedItems in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.imageCategory = .TONG_QUAN
                self.present(self.imagePicker, animated: true, completion: nil)
            })
        }
        selectionMenu.show(from: self)
    }
    
}

extension ImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)

        if let selectedImage = info[.originalImage] as? UIImage {
            CommonFunctions.saveImage(image: selectedImage, fileName: "imageUpload.jpg") { (success, imageURL) in
                let imageObject = IUImageObject(category: self.imageCategory, imageUrl: imageURL!.absoluteString, originImage: selectedImage)
                self.datasource.append(imageObject)
                self.collectionContainerView.reloadData(datasource: self.datasource)
            }
        }
    }
}
