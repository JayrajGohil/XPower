//
//  LeftMenuTableViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/23/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class LeftMenuTableViewController: UITableViewController {

    var menuSelectionClosure: ((IndexPath, Bool)-> Void)!
    var arrayMenu = [Menu.Home, Menu.Points, Menu.Score, Menu.Friends, Menu.Settings, Menu.Logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 108
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: LeftMenuHeaderView = tableView.dequeueReusableCell(withIdentifier: "LeftMenuHeaderView") as! LeftMenuHeaderView
        let keychain = KeychainWrapper()
        let username = keychain.myObject(forKey: kSecAttrAccount) as! String
        headerView.lblUsername.text = username
        
        return headerView
        /*
        static NSString *headerIdentifier = @"HeaderIdentifier";
        UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        [headerView.textLabel setFont:kFontHelveticaNeue];
        headerView.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"SectionHeaderText", @""),self.sbAcronym.text];
        
        return headerView;
         */
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMenu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeftMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as! LeftMenuTableViewCell

        // Configure the cell...

        cell.lblTitle.text = arrayMenu[indexPath.row]
        return cell
    }

 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuSelectionClosure(indexPath, true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
