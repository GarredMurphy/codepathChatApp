//
//  ChatViewController.swift
//  chat
//
//  Created by LinuxPlus on 10/2/18.
//  Copyright © 2018 LinuxPlus. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    var messages : [PFObject] = []
    
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var ChatTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatTable.dataSource = self
        ChatTable.separatorStyle = .none
        ChatTable.rowHeight = UITableViewAutomaticDimension
        ChatTable.estimatedRowHeight = 50
        fetchMessages()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        
        
        cell.messageLabel.text = messages[indexPath.row]["text"] as? String
        if let user = messages[indexPath.row]["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "_____"
        }
        
        
        
        return cell
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func onTimer() {
        
        fetchMessages()
    }

    
    
    func fetchMessages(){
        
        let query = Message.query()
        query?.includeKey("user")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        query?.findObjectsInBackground{ (messages: [PFObject]?,error: Error?) -> Void in
            if let messages = messages{
                self.messages = messages
                self.ChatTable.reloadData()
                print(messages)
                
            }
            
        }
        
    }
    
    
}
