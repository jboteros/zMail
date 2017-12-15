//

//  ViewController.swift
//  zMail
//
//  Created by Johnatan Botero on 12/14/17.
//  Copyright © 2017 Johnatan Botero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblDateMessage: UILabel!
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var textViewMessage: UITextView!
    @IBOutlet weak var containerMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClearMessages()
        
         self.view.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        
        containerMenu.layer.shadowColor = UIColor.black.cgColor
        containerMenu.layer.shadowOpacity = 1
        containerMenu.layer.shadowOffset = CGSize(width: 0, height: 10)
        containerMenu.layer.shadowRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(SetMessage), name: NSNotification.Name(rawValue: "SetMessage"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(ClearMessages), name: NSNotification.Name(rawValue: "ClearMessages"), object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func SetMessage(){
        
        let s = dataClass().messagesDefaults.object(forKey: "date") as? String
        
        lblDateMessage.text = s?.replacingOccurrences(of: "T", with: " ")
        lblTitleMessage.text = dataClass().messagesDefaults.object(forKey: "title") as? String
        textViewMessage.text = dataClass().messagesDefaults.object(forKey: "message") as? String
    }
    
    @objc func ClearMessages(){
        lblDateMessage.text = ""
        lblTitleMessage.text = ""
        textViewMessage.text = ""
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

