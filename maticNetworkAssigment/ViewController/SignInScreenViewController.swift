//
//  SignInScreenViewController.swift
//  maticNetworkAssigment
//
//  Created by QLC on 03/08/19.
//  Copyright © 2019 Vinayak Tudayekar. All rights reserved.
//

import UIKit
import Material
import Security
import CommonCrypto
import SwiftKeychainWrapper

class SignInScreenViewController: UIViewController
{
    
    fileprivate let constant: CGFloat = 32
    fileprivate var userName: ErrorTextField!
    fileprivate var passWord: TextField!
    var valid = validation()
    
    //MARK:-View lfe cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePasswordField()
        prepareEmailField()
        prepareResignResponderButton()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {

        userName.text = nil
        passWord.text = nil
        
    }
    override func viewWillDisappear(_ animated: Bool) {
       // NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    @IBAction func signInBtnClicked(_ sender: Any)
    {
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "passWord")
        let retrievedUserName: String? = KeychainWrapper.standard.string(forKey: "userName")
        
        if userName.text == retrievedUserName && passWord.text == retrievedPassword
        {
           
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else
        {
        valid.showAlertView(self, message: "Incorrect username or password")
        }
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
extension SignInScreenViewController {
    fileprivate func prepareEmailField()
    {
        userName = ErrorTextField()
        userName.placeholder = "Email"
        userName.clearButtonMode = .whileEditing
      
       // userName.detail = "Error, incorrect email"
        userName.isClearIconButtonEnabled = true
        userName.delegate = self
        userName.isPlaceholderUppercasedWhenEditing = true
      //  userName.placeholderAnimation = .hidden
        
      
         view.layout(userName).center(offsetY: -passWord.bounds.height - 140).left(80).right(80)
    }
    
    fileprivate func preparePasswordField() {
        passWord = TextField()
        passWord.placeholder = "Password"
      
        // passWord.detail = "At least 8 characters"
        passWord.clearButtonMode = .whileEditing
        passWord.delegate = self
        passWord.isSecureTextEntry = true
        passWord.isClearIconButtonEnabled = true
        passWord.isVisibilityIconButtonEnabled = true
        
        view.layout(passWord).center(offsetY: -passWord.bounds.height - 80).left(80).right(80)
    }
    
}

extension SignInScreenViewController: TextFieldDelegate {
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

