//
//  UITableView+Extension.swift
//  MoviesDemoApp
//
//  Created by karma on 9/21/22.
//

import UIKit

extension UITableView {
    
    func dequeueCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)") as! T
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }

}
