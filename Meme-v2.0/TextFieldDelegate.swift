//
//  TextFieldDelegate.swift
//  Meme-v2.0
//
//  Created by LIJO RAJU on 11/10/16.
//  Copyright © 2016 LIJORAJU. All rights reserved.
//

import Foundation
import UIKit

// MARK: - textFieldDelegate: NSObject, UITextFieldDelegate
class TextFieldDelegate: NSObject, UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField){ //This method is called when the user starts editing the textfield
        if textField.text == "TOP" || textField.text == "BOTTOM"{ //Clears default texts of textfield
            textField.text = ""
            
        }
        
    }
    
    //This method is called for the text field to process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //This method is called to dismiss the keyboard when the user taps the return button
        
        return true
        
    }
    
}
