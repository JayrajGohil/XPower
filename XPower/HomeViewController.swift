//
//  HomeViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblTotalSchoolPoint: UILabel!
    @IBOutlet weak var lblDailyPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        let schoolname = UserDefaults.standard.object(forKey: AppDefault.SchoolName) as! String

        let queue = OperationQueue()
        
        let op_dailyPoint = BlockOperation {
            WebServiceManager.dailyPoints(username: username, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    print("daily point")
                    if isSuccess{
                        self.lblDailyPoints.text = message;
                    }
                }
                
            })
        }
        
        let op_totalSchoolPoint = BlockOperation{
            WebServiceManager.totalSchoolPoints(schoolName: schoolname, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    print("total point")
                    if isSuccess{
                        self.lblTotalSchoolPoint.text = message
                    }
                }
                
            })
        }
        op_totalSchoolPoint.addDependency(op_dailyPoint)
        queue.addOperations([op_dailyPoint, op_totalSchoolPoint], waitUntilFinished: false)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
