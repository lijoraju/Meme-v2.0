//
//  MemeEditorVC.swift
//  Meme-v2.0
//
//  Created by LIJO RAJU on 11/10/16.
//  Copyright © 2016 LIJORAJU. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let textfieldDelegate = TextFieldDelegate()
    
    let memeAttributesForTextField = [NSStrokeColorAttributeName:UIColor.black, NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack",size:40)!, NSStrokeWidthAttributeName: -4.0] as [String : Any] //Intializing dictionary for default attributes of textfield
    
    //This method is the action for album buttom which enables the user to select an image froom photo library
    @IBAction func pickAnImageFromPhotoAlbum(_ sender: AnyObject) {
        pickImage(source: "album")
        
    }
    
    //This method is the action for camera button which allows user to take a picture using device's camera
    @IBAction func pickAnImageFromCamera(_ sender: AnyObject) {
        pickImage(source: "camera")
        
    }
    
    //Picks an image from specified source
    func pickImage(source:String) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        switch source { //Specifying source
        case "album":
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary //Specifying Photo Library as Source
        case "camera":
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera //Specifying Camera as Source
        default: break
            
        }
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //This method sets image to UIImageView and dismiss the selection menu after selecting image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.dismiss(animated: true, completion: nil) //Dismiss the selection list
            shareButton.isEnabled = true //Enabled share button to share Meme
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) //Enabling or disabling camera button upon avialability of camera
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
        setTextField(topTextField,defaultText: "TOP") //Intializing top textfield
        setTextField(bottomTextField,defaultText: "BOTTOM") //Intializing bottom textfield
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    //This function sets default text and text styles to top and bottom textfields
    func setTextField(_ textField:UITextField, defaultText:String) {
        textField.text = defaultText
        textField.defaultTextAttributes = memeAttributesForTextField
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = textfieldDelegate
        
    }
    
    //This method use to subscribe keyboard notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorVC.keyboardWillShow(_ :)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorVC.keyboardWillHide(_ :)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //This method use to unsubscribe keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //This method  is used shift the view's frame up from when keyboard appears
    func keyboardWillShow(_ notification:NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
            
        }
        
    }
    
    //This method  is used shift the view's frame down from when keyboard disappears
    func keyboardWillHide(_ notification:NSNotification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = 0
            
        }
        
    }
    
    //This method is used to obtain keyboard height
    func getKeyboardHeight(_ notification:NSNotification)-> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        
        return keyboardSize.cgRectValue.height
        
    }
    
    //Method to save created Meme
    func save()-> MemeObject {
        let meme = MemeObject( topText: topTextField.text!, bottomText:bottomTextField.text!, image:imagePickerView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        return meme
        
    }
    
    //Method to generate the created Meme
    func generateMemedImage() -> UIImage {
        bottomToolBar.isHidden = true //Hide top and bottom toolbars
        topToolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size) //Render image to view
        view.drawHierarchy(in: self.view.frame,afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        bottomToolBar.isHidden = false //Show top and bottom toolbars
        topToolBar.isHidden = false
        
        return memedImage
        
    }
    
    //Share the Meme over facebook,twitter,instagram
    @IBAction func shareMeMe(_ sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        activityController.completionWithItemsHandler = {
            activity,completed,item,error in if completed {
                let _ = self.save()
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    
    //Cancel Meme generated
    @IBAction func cancelMeme(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

