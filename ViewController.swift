//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by Yewon Seo on 2020/03/27.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController() // this will handle the task of fetching an image from ios system
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
    }

    @IBAction func photosButtomPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary // what type of task: camera or photo album
        imagePicker.allowsEditing = true // should the user be able to zoom in before getting the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func videoButtonPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // this will launch video in the camera app
        imagePicker.videoQuality = .typeMedium
        launchCamera()
        
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        launchCamera()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[.mediaURL] as? URL { // if we have a video this will be true
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
            }
        } else { // if we have an image
            var image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            image = textToImage(drawText: "Photo By. Yenny", inImage: image!, atPoint: CGPoint(x: 20, y: 20))
            imageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // register touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began")
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let p = touches.first?.location(in: view)
        print("moved to: \(String(describing: p))")
        imageView.transform = CGAffineTransform(translationX: p!.x, y: 0)
    }
    
    
    
    // save image to camera roll
    
    @objc func image(_ image:UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let image = resizeImage(image: imageView.image!, newWidth: 250)
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    // resize image
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
    // add text onto the image
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}

