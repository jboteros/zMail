//
//  MessagesController.swift
//  zMail
//
//  Created by Johnatan Botero on 12/14/17.
//  Copyright © 2017 Johnatan Botero. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessagesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tView: UITableView!
    
    var arrRes = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tView.register(UINib(nibName: "MessagesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "messagesList")
        
        self.tView.backgroundColor = #colorLiteral(red: 0.09545650333, green: 0.09545981139, blue: 0.09545803815, alpha: 1)
        
        Alamofire.request("https://api.myjson.com/bins/54tf5").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar[].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesList", for: indexPath) as! MessagesTableViewCell
        
        //let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        var dict = arrRes[(indexPath as NSIndexPath).row]
        cell.messageTitle?.text = dict["title"] as? String
        cell.messageMessage?.text = dict["message"] as? String
        
        if dict["unread"] as! Bool == true {
            cell.btnIndicator.isHidden = false
        } else {
            cell.btnIndicator.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        
        var dict = arrRes[(indexPath as NSIndexPath).row]
        
        dataClass().messagesDefaults.set(String(describing: dict["date"]!), forKey: "date")
        dataClass().messagesDefaults.set(String(describing: dict["title"]!), forKey: "title")
        dataClass().messagesDefaults.set(String(describing: dict["message"]!), forKey: "message")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetMessage"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            arrRes.remove(at: indexPath.row)
            tView.beginUpdates()
            tView.deleteRows(at: [indexPath], with: .middle)
            tView.endUpdates()
            
        }
    }
    
    @IBAction func btnDismissAllAction(_ sender: Any) {
        

             arrRes.removeAll()
            tView.reloadData()

             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ClearMessages"), object: nil)
    
        
    }
    
    func dismissAll(){
        for i in 0...arrRes.count{
            let indexpath = IndexPath(row: i, section: 0)
            arrRes.remove(at: indexpath.row)
            tView.beginUpdates()
            tView.deleteRows(at: [indexpath], with: .middle)
            tView.endUpdates()
        }
    }
}

