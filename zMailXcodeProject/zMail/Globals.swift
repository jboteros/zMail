//
//  Globals.swift
//  zMail
//
//  Created by Johnatan Botero on 12/14/17.
//  Copyright © 2017 Johnatan Botero. All rights reserved.
//

import Foundation
import UIKit

extension  UITableViewCell{
    
    func cornerRadiusX(button:UIButton, i: CGFloat){
        button.layer.cornerRadius = i
    }
    
    func cornerRadiusAnyX(any:AnyObject, i:CGFloat){
        any.layer.cornerRadius = i
    }
    
}
