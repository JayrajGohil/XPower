//
//  PointViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/30/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

class PointViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentPoints: UISegmentedControl!
    @IBOutlet weak var tblPoint: UITableView!
    @IBOutlet weak var btnDate: UIButton!
    
    var arrayPoint = [PointTable]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tblPoint.register(UINib(nibName:"PointTableViewCell", bundle: nil), forCellReuseIdentifier: "PointTableViewCell")
        self.tblPoint.estimatedRowHeight = 60
        
        self.segmentPoints.selectedSegmentIndex = 0;
        loadPoints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentValueChange(_ sender: Any) {
        if self.segmentPoints.selectedSegmentIndex == 0 {
            loadPoints()
        }
        else {
            loadDailyDeeds()
        }
    }

    @IBAction func pressDateBtn(_ sender: Any) {
    }
    
    func loadPoints() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointListTable { (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                
                self.arrayPoint = responseData;
                self.tblPoint.reloadData();
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func loadDailyDeeds() {
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPoint.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PointTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PointTableViewCell") as! PointTableViewCell
        cell.lblTitle.text = arrayPoint[indexPath.row].descriptionField
        return cell
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
