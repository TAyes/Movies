//
//  UIViewController+Error.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation
import UIKit

public extension UIViewController {
    func show(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
