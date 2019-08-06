//
//  File.swift
//  maticNetworkAssigment
//
//  Created by Vinayak Tudayekar on 05/08/19.
//  Copyright © 2019 Vinayak Tudayekar. All rights reserved.
//

import Foundation
import UIKit
struct validation {
    //validate EmailID text
    func isValidEmail(_ testStr:String) -> Bool
    {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func showAlertView(_ targetViewController:UIViewController,message:String)  {
        
        let alert = UIAlertController(title: "FieldSense", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        targetViewController.present(alert, animated: true, completion: nil)
    }
   
    
}
