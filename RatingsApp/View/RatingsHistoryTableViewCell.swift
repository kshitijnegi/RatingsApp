//
//  RatingsHistoryTableViewCell.swift
//  RatingsApp
//
//  Created by Kshitij Negi on 18/04/20.
//  Copyright © 2020 Kshitij Negi. All rights reserved.
//

import UIKit

class RatingsHistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var dateTimeLabel: UILabel!

    func configureCell(rating: String, date: String) {
        ratingLabel.text = rating
        dateTimeLabel.text = date
    }
}
