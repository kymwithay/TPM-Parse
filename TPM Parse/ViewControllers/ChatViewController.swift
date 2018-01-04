//
//  ChatViewController.swift
//  TPM Parse
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var chatMessageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSendTap(_ sender: Any) {
        print ("chat sending")
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
