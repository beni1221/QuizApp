//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by Arben on 3.5.23.
//

import UIKit

class QuizTableViewCell: UITableViewCell, CellIdentifiable {
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
}
