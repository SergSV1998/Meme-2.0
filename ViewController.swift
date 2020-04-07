//
//  ViewController.swift
//  MemeMe
//
//  Created by Sergey on 22/3/20.
//  Copyright © 2020 Sergey. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate{
    var memedImage : UIImage!
    @IBOutlet weak var imageView: UIImageView!
    var memeToEdit : Meme!
    var cancelButtonIsEnabled: Bool!
    @IBOutlet weak var cameraButton :UIButton!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var TopToolbar: UIToolbar!
    @IBOutlet weak var BottomToolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextfield.text = "Text"
        bottomTextfield.text = "Text"
         topTextfield.textAlignment = NSTextAlignment.center
            bottomTextfield.textAlignment = NSTextAlignment.center
        topTextfield.delegate = self
        topTextfield.allowsEditingTextAttributes = false
         bottomTextfield.allowsEditingTextAttributes = false
         topTextfield.isEnabled = false
        bottomTextfield.isEnabled = false
        bottomTextfield.delegate = self
        bottomTextfield.defaultTextAttributes = memeTextAttributes
        
        topTextfield.defaultTextAttributes = memeTextAttributes
     if let cancelButtonIsEnabled = cancelButtonIsEnabled {
               cancelButton.isEnabled = cancelButtonIsEnabled
           }
            
        }
        let memeTextAttributes:[NSAttributedString.Key: Any] = [
                  NSAttributedString.Key.strokeColor: UIColor.black,
                  NSAttributedString.Key.foregroundColor: UIColor.white,
                  NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                  NSAttributedString.Key.strokeWidth: 4.0]
    //if let memeToEdit = memeToEdit {
    ///topTextfield.text = memeToEdit.topText
    ///bottomTextfield.text = memeToEdit.bottomTextfield
    ///imageView.image = memeToEdit.memedImage
    ///}
        override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
         subscribeToKeyboardNotifications()
                cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        ///it was true
                 navigationController?.navigationBar.isHidden = false
                              tabBarController?.tabBar.isHidden = true
        subscribeToKeyboardNotifications()
        ///cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
         ///navigationController?.navigationBar.isHidden = false
                      ///tabBarController?.tabBar.isHidden = true
        shareButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    func image(_image :UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }else{
            let ac = UIAlertController(title: "Saved!", message:"Your altered image has been saved to your photos", preferredStyle: .alert )
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
           unsubscribeFromKeyboardNotifications()
           navigationController?.navigationBar.isHidden = false
           tabBarController?.tabBar.isHidden = false
       
    }
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           textField.text = ""
           return true
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
           textField.resignFirstResponder()
        return true
       }
       func getKeyboardHeight(_ notification:Notification) -> CGFloat {

           let userInfo = notification.userInfo
           let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
           return keyboardSize.cgRectValue.height
       }
    @objc func keyboardWillShow(_ notification:Notification) {
          if bottomTextfield.isEditing {
                         view.frame.origin.y = -getKeyboardHeight(notification)
                     }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
          if bottomTextfield.isEditing {
                         view.frame.origin.y = 0
                     }
        }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       func unsubscribeFromKeyboardNotifications() {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       
}
    ///@IBAction func pickAnImageFromAlbum(_ sender: Any) {
     
    ///pickAnImage(UIImagePickerController.SourceType.photoLibrary)
     
    ///}
    func Save(){
        let sharedImage = generateMemedImage()
        let meme = Meme (BottomText: topTextfield.text!, TopText: bottomTextfield.text!, originalImage: imageView.image!, memedImage: sharedImage)
           let object = UIApplication.shared.delegate
               let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
           ///(UIApplication.shared.delegate as! AppDelegate).memes.append(xpto)
               ///}
    ///func saveMeme(){
            ///let sharedImage = generateMemedImage()
            ///let meme = Meme(BottomText: topTextfield.text!, TopText: bottomTextfield.text!, originalImage: imageView.image!, memedImage: sharedImage)
            ///let object = UIApplication.shared.delegate
            ///let appDelegate = object as! AppDelegate
            ///appDelegate.memes.append(meme)
            ///print("SAVED\(appDelegate.memes.count)")
        }
     func generateMemedImage() -> UIImage {
           topTextfield.isHidden = false
           bottomTextfield.isHidden = false
        TopToolbar.isHidden = true
        BottomToolbar.isHidden = true
           UIGraphicsBeginImageContext(self.view.frame.size)
           view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
           let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
           
          topTextfield.isHidden = false
           bottomTextfield.isHidden = false
        TopToolbar.isHidden = false
        BottomToolbar.isHidden = false
           return memeImage
       }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
     
        pickAnImage(UIImagePickerController.SourceType.camera)
     
        
    }
    @IBAction func cancelEditing(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
    @IBAction func SharedImageGroup(_ sender: Any){
     let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
        ///imagePicker.allowsEditing = true
    imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    topTextfield.isEnabled = true
    bottomTextfield.isEnabled = true
    cameraButton.isEnabled = false
    shareButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    
    }
    @IBAction func shareimage(_ sender: Any) {
        memedImage = generateMemedImage()
        let imageToShare = [memedImage]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if(!completed) {
                return
            }
            ///self.Save(memedImage: UIImage)
            self.Save()
            self.navigationController?.popToRootViewController(animated: true)
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    func pickAnImage(_ source: UIImagePickerController.SourceType) {
    
        let pickerController = UIImagePickerController()
    
        pickerController.delegate = self
    
        pickerController.sourceType = source
    
        present(pickerController, animated: true, completion: nil)
    
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
                 if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    imageView.image = image

                                             dismiss(animated: true, completion: nil)
                    
        }
        func ImagePickerControllerDidCancel(_picker: UIImagePickerController){
            dismiss(animated: true, completion: nil)
        }
        func generateMemedImage() -> UIImage {

            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            // TODO: Show toolbar and navbar

            return memedImage
    }
            func checkShareButton() {
        if imageView.image != nil {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
            func hideTextfield(isHiden: Bool) {
            if isHiden {
                topTextfield.isHidden = true
                bottomTextfield.isHidden = true
            } else {
                topTextfield.isHidden = false
                bottomTextfield.isHidden = false
            }
                func hideToolbar(isHidden: Bool){
                if isHidden{
                    TopToolbar.isHidden = true
                    BottomToolbar.isHidden = true
                }
                else {
                    TopToolbar.isHidden = false
                    BottomToolbar.isHidden = false
                    }
                let sharedImage = generateMemedImage()
    let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
    self.present(activityController, animated: true, completion: nil)
 activityController.completionWithItemsHandler = {(activity, success, items, error) in
            }
            
    }
}
}
}

}
