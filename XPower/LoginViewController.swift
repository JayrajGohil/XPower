//
//  ViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var switchKeepLogin: UISwitch!
    
    var alertEmail: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden  = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func pressLoginBtn(_ sender: Any) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.loginUser(username: self.txtUsername.text!, password: self.txtPassword.text!, completionHandler: {(isSuccess, dictData, message) -> () in
            
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                if isSuccess {
                    
                    // Store password in Keychain
                    let keyWrapper = KeychainWrapper()
                    keyWrapper.mySetObject(dictData.password, forKey: kSecValueData)
                    keyWrapper.mySetObject(dictData.username, forKey: kSecAttrAccount)
                    keyWrapper.writeToKeychain()
                    
                    // check if keep me login on then store in userdefaults
                    if self.switchKeepLogin.isOn {
                        UserDefaults.standard.set(true, forKey: "keepLogIn")
                        UserDefaults.standard.synchronize()
                    }
                    
                    // Load Home view
                    CommonViewController.loadHomeView()
                }
                else {
                    let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: { })
                }
            }
        })
    }
    
    @IBAction func pressClearBtn(_ sender: Any) {
        self.txtUsername.text = ""
        self.txtPassword.text = ""
    }
    
    @IBAction func pressForgotPasswordBtn(_ sender: Any) {
        
        alertEmail = UIAlertController(title: "Forgot Password", message: nil, preferredStyle: .alert)
        let actionSend = UIAlertAction(title: "Send", style: .default, handler: {action in
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let emailid = self.alertEmail.textFields?.first?.text
            
            WebServiceManager.forgotPassword(email: emailid!, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertEmail.addTextField { (txtEmailAddress) in
            txtEmailAddress.placeholder = "Please enter your email address"
            txtEmailAddress.delegate = self
        }
        alertEmail.addAction(actionCancel)
        alertEmail.addAction(actionSend)
        actionSend.isEnabled = false
        self.present(alertEmail, animated: true, completion: nil)
    }
    
    @IBAction func valueChangeKeepLogin(_ sender: Any) {
    }
    
    // MARK: Textfield Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.characters.count)! > 10 {
            alertEmail.actions.last?.isEnabled = true
        }
        else {
            alertEmail.actions.last?.isEnabled = false
        }
        return true
    }
}

