//
//  ChatViewController.swift
//  TPM Parse
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messages: [PFObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
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
    
    @objc func onTimer() {
        // Add code to be run periodically
        print ("fetcning messages")
        
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
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSendTap(_ sender: Any) {
        print ("chat sending")
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageTextField.text ?? ""
        
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
