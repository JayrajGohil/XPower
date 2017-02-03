//
//  ChatViewController.swift
//  XPower
//
//  Created by Software Merchant on 2/1/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import MBProgressHUD

extension NSDate {
    
    // or an extension function to format your date
    func formattedWith(format:String)-> String {
        let formatter = DateFormatter()
        //formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)  // you can set GMT time
        formatter.timeZone = NSTimeZone.local        // or as local time
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }
    
}

class ChatViewController: UIViewController {

    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var txtvMessage: UIView!
    @IBOutlet weak var btnSend: UIView!
    
    var chatMessageModel:ChatGetMessageModel = ChatGetMessageModel(fromDictionary: NSDictionary())
    var username:String? = nil
    
    var receiver:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cd = NSDate.formattedWith(NSDate())
        username = UserDefaults.standard.object(forKey: AppDefault.Username) as? String
        self.loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressSendBtn(_ sender: Any) {
    }
    
    func loadMessages() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.chatGet(sender: username!, reciever: receiver!, completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                if isSuccess {
                    self.chatMessageModel = responseData;
                    self.tblChat.reloadData();
                }
                else{
                    let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: { })
                }
            }
        })
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessageModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        
        let msg = self.chatMessageModel.messages[indexPath.row]
        cell.lblMessage.text = msg.message
        if username == msg.sender {
            cell.lblMessage.textAlignment = NSTextAlignment.right
            cell.constraint_lblTitle_Leading.constant = 30;
        }
        else{
            
            cell.lblMessage.textAlignment = NSTextAlignment.left
            cell.constraint_lblTitle_Trailing.constant = 30;
        }
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
