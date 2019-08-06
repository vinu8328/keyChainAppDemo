//
//  NewAccountScreenViewController.swift
//  maticNetworkAssigment
//
//  Created by Vinayak Tudayekar on 03/08/19.
//  Copyright © 2019 Vinayak Tudayekar. All rights reserved.
//

import UIKit
import Material
import Security
import CommonCrypto
import SwiftKeychainWrapper
import Security
class NewAccountScreenViewController: UIViewController
{
    fileprivate var userName: ErrorTextField!
    fileprivate var passWord: TextField!
    fileprivate let constant: CGFloat = 32
    
    lazy var keychain = KeychainFacade()
    var valid = validation()
    
    //MARK:-View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.backgroundColor = Color.grey.lighten5
        
        preparePasswordField()
        prepareEmailField()
        prepareResignResponderButton()
        
    }
    //MARK:-Button action
    @IBAction func creatNewAccontBtn(_ sender: Any)
    {
        
        if ((self.userName.text?.isEmpty)! || (self.passWord.text?.isEmpty)!)
        {
            valid.showAlertView(self, message: "Please enter a valid data in Email ID and Password")
           
        }
      
        else if valid.isValidEmail(self.userName.text!)
        {
            encryptDecrypt()
            // Instantiate SecondViewController
            let SignInScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInScreenViewController") as! SignInScreenViewController
       self.navigationController?.pushViewController(SignInScreenViewController, animated: true)
        }
        else
        {
            valid.showAlertView(self, message: "Please enter a valid email id")
            
        }
      
    }
    //MARK:-DATA encryption and decription
    private func encryptDecrypt()
    {
        let facade = KeychainFacade()
    
        var username = userName.text
        var password = passWord.text
            
        
        let  userNamePassword = username! + password!
       
        do {
            
            
            if let encryptedData = try facade.encrypt(text: userNamePassword)
            {
               
                if let userName = userName.text,
                    let passWord = passWord.text {
                    do {
                        try KeychainWrapper.standard.set(userName, forKey: "userName")
                        try KeychainWrapper.standard.set(passWord, forKey: "passWord")
                        try KeychainWrapper.standard.set("\(encryptedData.hashValue)", forKey: "userNamePassword")
                        
                        
                    }
                    catch let Error as Error
                    {
                        print("Could not store credentials in the keychain. \(Error)")
                    }
                    catch
                    {
                        print(error)
                    }
                }
                //data decryption
                if let decryptedData = try facade.decrypt(data: encryptedData)
                {
                    print("Data decrypted successfully")
                    print(String(data: decryptedData, encoding: .utf8) ?? "")
                }
            }
        } catch {
            print(error)
        }
        
    
    }
  
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Resign", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        
        view.layout(btn).width(50).height(constant).top(40).right(20)
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleResignResponderButton(button: UIButton)
    {
        userName?.resignFirstResponder()
        passWord?.resignFirstResponder()
        
    }
   
    
   
}
extension NewAccountScreenViewController {
    fileprivate func prepareEmailField() {
        userName = ErrorTextField()
        userName.placeholder = "Email"
        userName.text = ""
      //  userName.detail = "Error, incorrect email"
        userName.clearButtonMode = .whileEditing
        userName.isClearIconButtonEnabled = true
        userName.delegate = self
        userName.isPlaceholderUppercasedWhenEditing = true
       
        view.layout(userName).center(offsetY: -passWord.bounds.height - 140).left(70).right(70)
    }
    
    fileprivate func preparePasswordField() {
        passWord = TextField()
        passWord.placeholder = "Password"
        //passWord.detail = "At least 8 characters"
        passWord.clearButtonMode = .whileEditing
        passWord.delegate = self
        passWord.isSecureTextEntry = true
        passWord.isClearIconButtonEnabled = true
        passWord.isVisibilityIconButtonEnabled = true
       
        view.layout(passWord).center(offsetY: -passWord.bounds.height - 80).left(70).right(70)
    }
//    class func passwordHash(from userName: String, passWord: String) -> String {
//        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
//        return "\(passWord).\(userName).\(salt)".sha256()
//    }
}

extension NewAccountScreenViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        self.view.endEditing(true)
        
        return true
    }
    
}


