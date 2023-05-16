//
//  CellIdentifiable.swift
//  QuizApp
//
//  Created by Arben on 3.5.23.
//

import UIKit

protocol CellIdentifiable {
    static var nib: UINib { get }
    static var identifier: String { get }
}

extension CellIdentifiable {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }
}
