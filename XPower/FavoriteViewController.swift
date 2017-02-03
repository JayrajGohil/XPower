//
//  FavoriteViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/30/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,PointTableCellDelegate  {

    @IBOutlet weak var tblPoint: UITableView!
    
    var arrayFav = [FavoriteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "addpointsbackground")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
        self.tblPoint.register(UINib(nibName:"PointTableViewCell", bundle: nil), forCellReuseIdentifier: "PointTableViewCell")
        self.tblPoint.estimatedRowHeight = 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointFavorite(username: username, completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                
                self.arrayFav = responseData;
                self.tblPoint.reloadData();
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PointTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PointTableViewCell") as! PointTableViewCell
        cell.delegate = self;
        cell.tag = indexPath.row
        cell.lblTitle.text = arrayFav[indexPath.row].favorite
        return cell
    }
    
    func pointDeedAdded(at: Int) {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        let deedSelected = arrayFav[at].favorite
        let dateToday = Date()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointAddDeeds(username: username, deed: deedSelected!, date: dateToday, completionHandler: {(isSuccess, message) -> () in
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        })
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
