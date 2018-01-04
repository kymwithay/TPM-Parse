//
//  ChatViewController.swift
//  TPM Parse
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse
import AlamofireImage

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messages: [PFObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        // Auto size row height based on cell autolayout constraints
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        messagesTableView.estimatedRowHeight = 50
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        messagesTableView.insertSubview(refreshControl, at: 0)
        
        // remove the separator
        messagesTableView.separatorStyle = .none
        
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let message = self.messages {
            return message.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        cell.messages = (self.messages?[indexPath.row])!
        return cell
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        onTimer()
        refreshControl.endRefreshing()
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        query.whereKeyExists("text").includeKey("user")
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.messages = objects
                self.messagesTableView.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onSendTap(_ sender: Any) {
        print ("chat sending")
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print ("Message was saved")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
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
