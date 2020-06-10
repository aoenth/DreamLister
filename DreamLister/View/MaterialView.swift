//
//  MaterialView.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-24.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView { // Anything that inherits from UIView will also have the styling that will be added in this swift file.
    // IBInspectable - toggling inside the storyboard
    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
        
        
    }

}
