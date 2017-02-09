//
//  ViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD
import LocalAuthentication

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var switchKeepLogin: UISwitch!
    
    var alertEmail: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "Tree")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        imageView.addSubview(blurEffectView)
        
        
        
        let keychain = KeychainWrapper()
        let username = keychain.myObject(forKey: kSecAttrAccount) as? String
        if let user = username, user.characters.count > 0{
            let isKeepLogIn = UserDefaults.standard.bool(forKey: AppDefault.KeepLogIn)
            if isKeepLogIn {
                let touch = UserDefaults.standard.bool(forKey: AppDefault.TouchID)
                if  touch {
                    authenticateUser()
                }
                else {
                    // Load Home view
                    CommonViewController.loadHomeView()
                }
            }
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        CommonViewController.loadHomeView()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
                    keyWrapper.mySetObject(self.txtPassword.text, forKey: kSecValueData)
                    keyWrapper.mySetObject(dictData.username, forKey: kSecAttrAccount)
                    keyWrapper.writeToKeychain()
                    
                    UserDefaults.standard.set(dictData.username, forKey: AppDefault.Username)
                    UserDefaults.standard.set(dictData.schoolName, forKey: AppDefault.SchoolName)
                    
                    // check if keep me login on then store in userdefaults
                    if self.switchKeepLogin.isOn {
                        UserDefaults.standard.set(true, forKey: AppDefault.KeepLogIn)
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

