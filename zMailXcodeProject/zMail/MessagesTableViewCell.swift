//
//  MessagesTableViewCell.swift
//  zMail
//
//  Created by Johnatan Botero on 12/14/17.
//  Copyright © 2017 Johnatan Botero. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messageMessage: UILabel!
    @IBOutlet weak var btnIndicator: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadiusX(button: btnIndicator, i: btnIndicator.bounds.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
    @IBAction func btnDeleteRowAction(_ sender: Any) {

    }
}
