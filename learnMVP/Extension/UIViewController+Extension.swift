//
//  UIViewController+Extension.swift
//  MoviesDemoApp
//
//  Created by karma on 9/23/22.
//

import UIKit

extension UIViewController {
    
    func alert(message: String?, title: String? = nil, okAction: (()->())? = nil) {
        let alertController = getAlert(message: message, title: title)
        alertController.addAction(title: "OK", handler: okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getAlert(message: String?, title: String?, style: UIAlertController.Style? = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
    }
    
}

extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (()->())? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: {_ in
            handler?()
        })
        self.addAction(action)
    }
    
}
