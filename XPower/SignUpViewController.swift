//
//  SignUpViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgvBackground: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden  = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden  = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pressEmailBtn(_ sender: Any) {
        
        let alertEmailHost = UIAlertController(title: "XPower", message: "Select Hostname", preferredStyle: .actionSheet)
        let actionHavord = UIAlertAction(title: "@haverford.org", style: .default, handler: {(action) -> Void in
            self.btnEmail.titleLabel?.text = "@haverford.org"
        })
        let actionAgnes = UIAlertAction(title: "@agnesirwin.org", style: .default, handler: {action in
            self.btnEmail.titleLabel?.text = "@agnesirwin.org"
        })
        alertEmailHost.addAction(actionHavord)
        alertEmailHost.addAction(actionAgnes)
        self.present(alertEmailHost, animated: true, completion: nil)
    }
    
    @IBAction func pressSignupBtn(_ sender: Any) {
        
        if (self.txtUsername.text?.isEmpty)! || (self.txtPassword.text?.isEmpty)! || (self.txtConfirmPassword.text?.isEmpty)! || (self.txtEmail.text?.isEmpty)! {
            self.showAlert("Error", message: "Plase fill all the informaiton")
            return
        }
        else if self.txtPassword.text != self.txtConfirmPassword.text {
            self.showAlert("XPower", message: "Confirm password does not match with password")
            return
        }
        
        let strEmail = "\(txtEmail.text! + (btnEmail.titleLabel?.text)!)"
        let strSchoolName = (btnEmail.titleLabel?.text == "@haverford.org") ? "Haverford" : "Agnes Irwin School"
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.signup(username: self.txtUsername.text!, password: self.txtPassword.text!, email: strEmail, schoolname: strSchoolName, avatar: false, avatarURl: "", completionHandler: {(isSuccess, responseData, error) -> () in
            
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showAlert("XPower", message: error)
            }
        })
    }
    
    func showAlert(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
