//
//  SelfConfiguringCell.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import UIKit

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: Contents)
}

