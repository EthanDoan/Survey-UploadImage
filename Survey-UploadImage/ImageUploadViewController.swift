//
//  ImageUploadViewController.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

let SC_WIDTH = UIScreen.main.bounds.size.width
let SC_HEIGHT = UIScreen.main.bounds.size.height

class ImageUploadViewController: UIViewController {

    var scrollView: CustomScrollView?
    
    var shview: SectionHeaderView!
    var collectionContainerView: IUCollectionContainerView!
    var datasource: Array<IUImageObject>!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = Array<IUImageObject>()
        
        
        shview = SectionHeaderView(title: "Header title string")
        shview.shotBtn.addTarget(self, action: #selector(ImageUploadViewController.shotBtnTapped), for: .touchUpInside)
        
        collectionContainerView = IUCollectionContainerView(datasource: datasource)
        
        scrollView = CustomScrollView(views: [shview, collectionContainerView])
        self.view.addSubview(scrollView!)
        
    }
    
    @objc func shotBtnTapped() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage, fileName: String) -> URL? {
        
        let fileManager = FileManager.default
        
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let timestampStr = "\(NSDate().timeIntervalSince1970 * 1000)"
        let fileName = "\(fileName)-\(timestampStr)"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        
        if (fileManager.fileExists(atPath: fileURL.path)) {
            do {
                // writes the image data to disk
                try fileManager.removeItem(atPath: fileURL.path)
            } catch {
                print("error delete file:", error)
            }
        }
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
                return fileURL
            } catch {
                print("error saving file:", error)
                return nil
            }
        }
        return nil
    }
}

extension ImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)

        if let selectedImage = info[.originalImage] as? UIImage {

            let imgUrl: URL = self.saveImage(image: selectedImage, fileName: "imageUpload.jpg")!
            
            let imageObject = IUImageObject(category: .TONG_QUAN, imageUrl: imgUrl.absoluteString, originImage: selectedImage)
            datasource.append(imageObject)
            collectionContainerView.reloadData(datasource: datasource)
        }
    }
    
}


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

//    func saveImage(imageName: String){
//        //create an instance of the FileManager
//        let fileManager = FileManager.default
//        //get the image path
//        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
//        //get the image we took with camera
//        let image = imageView.image!
//        //get the PNG data for this image
//        let data = UIImagePNGRepresentation(image)
//        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
//    }
