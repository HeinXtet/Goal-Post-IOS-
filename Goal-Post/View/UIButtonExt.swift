//
//  UIButtonExt.swift
//  Goal-Post
//
//  Created by HeinHtet on 8/11/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    
    func selectedBgColor() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.7843137255, alpha: 1)
    }
    func unSelectedBgColor() {
        self.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.8274509804, blue: 0.8392156863, alpha: 1)
    }
}

