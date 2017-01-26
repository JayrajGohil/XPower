//
//  CommonViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/24/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func loadLoginVieww() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        appDelegate.window?.rootViewController = homeController
    }

    class func loadHomeView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = SVMenuOptionManager.sharedInstance.slidingPanel
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
