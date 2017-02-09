//
//  HomeViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//progresscell
    @IBOutlet weak var lblTotalSchoolPoint: UILabel!
    @IBOutlet weak var lblDailyPoints: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var progModel:ProgressModel?
    
    let reuseIdentifier = "progresscell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "homescreenbackground")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
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
        
        let op_ProgressPoint = BlockOperation{
            WebServiceManager.progressPoint(username: username, year: "2017", completionHandler: { (isSuccess, responseData, message) in
                
                DispatchQueue.main.async {
                    print("total point")
                    if isSuccess{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.progModel = responseData
                        if self.progModel?.error == 1 {
                            self.showAlert("XPower", message: "Invalid Username")
                        }
                        else if self.progModel?.error == 2 {
                            self.showAlert("XPower", message: "Invalid Year")
                        }
                        else{
                            self.loadProgress()
                        }
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
                
            })
        }
        op_totalSchoolPoint.addDependency(op_dailyPoint)
        op_ProgressPoint.addDependency(op_totalSchoolPoint)
        queue.addOperations([op_dailyPoint, op_totalSchoolPoint, op_ProgressPoint], waitUntilFinished: false)
        
    }
    
    func loadProgress() {
        
        self.collectionView.reloadData()
    }
    
    func showAlert(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if progModel != nil && progModel?.error == 0 {
            return 12
        }
        else{
            return 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProgressCollectionViewCell
        
        let v = ProgressView(frame: cell.contentView.bounds)
        
        switch indexPath.row {
        case 0:
            let per = ((progModel?.jan)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jan")
        case 1:
            let per = ((progModel?.feb)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Feb")
        case 2:
            let per = ((progModel?.mar)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Mar")
        case 3:
            let per = ((progModel?.apr)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Apr")
        case 4:
            let per = ((progModel?.may)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "May")
        case 5:
            let per = ((progModel?.jun)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jun")
        case 6:
            let per = ((progModel?.jul)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jul")
        case 7:
            let per = ((progModel?.aug)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Aug")
        case 8:
            let per = ((progModel?.sep)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Sep")
        case 9:
            let per = ((progModel?.oct)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Oct")
        case 10:
            let per = ((progModel?.nov)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Nov")
        case 11:
            let per = ((progModel?.dec)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Dec")
        default:
            v.animateProgressView(percentage: 0, month: "")
        }
        
        cell.contentView.addSubview(v)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
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
