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
        self.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }
    func unSelectedBgColor() {
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
}
