//
//  MediaAccess.swift
//  DRBINEW
//
//  Created by mac on 23/11/1441 AH.
//  Copyright © 1441 a2solution. All rights reserved.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?,fileName:String,fileSize:String)
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage? ,fileName:String,fileSize:String) {
        controller.dismiss(animated: true, completion: nil)

        
        self.delegate?.didSelect(image: image,fileName:fileName,fileSize:fileSize)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil,fileName: "",fileSize: "")
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var fileName = ""
        var fileSize = ""
        var imageSize = Float()
        var data = Data()
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            fileName = url.lastPathComponent
           // fileType = url.pathExtension
        }
        print("-----",fileName)
        
        guard let image = info[.editedImage] as? UIImage else {
            
            return self.pickerController(picker, didSelect: nil,fileName: "",fileSize:"")
        }
        data = image.jpegData(compressionQuality: 1.0)!
          imageSize = Float(Double(data.count)/1024/1024)
            fileSize = String(format: "%.3f",imageSize)+"MB"
      //    if imageSize <= 5.00{
            return  self.pickerController(picker, didSelect: image,fileName: fileName,fileSize:fileSize)
         
//          }else{
//
//        return self.pickerController(picker, didSelect: nil,fileName: "",fileSize: "")
//        }
        
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}


