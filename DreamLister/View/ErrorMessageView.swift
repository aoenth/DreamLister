//
//  ErrorMessageView.swift
//  DreamLister
//
//  Created by Kevin Peng on 2020-06-10.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import MBProgressHUD

final class ErrorMessageView {
    static func show(errorMessage: String, on view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView
        hud.label.text = "Unable to fetch Store Types"
        hud.customView = UIImageView(image: #imageLiteral(resourceName: "ErrorIcon"))
        hud.show(animated: true)
        hud.isSquare = true
        hud.hide(animated: true, afterDelay: 3)
    }
}
