//
//  RatingSelectionViewController.swift
//  RatingsApp
//
//  Created by Kshitij Negi on 17/04/20.
//  Copyright © 2020 Kshitij Negi. All rights reserved.
//

import UIKit

protocol RangeSelectable {
    func allowedRange(min: Float, max: Float)
}

final class RatingSelectionViewController: UIViewController {
    
    @IBOutlet private weak var maxValueLabel: UILabel!
    @IBOutlet private weak var minValueLabel: UILabel!
    @IBOutlet private weak var currentValueLabel: UILabel!
    @IBOutlet private weak var rangeSlider: UISlider!
    
    private lazy var dataBase: Database = DataBaseHelper()
    
    private var minRange : Float = 0
    private var maxRange : Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialConfigurations()
    }
}

extension RatingSelectionViewController: RangeSelectable {
    func allowedRange(min: Float, max: Float) {
        minRange = min
        maxRange = max
    }
}

// Private Methods
private extension RatingSelectionViewController {
    
    func doInitialConfigurations() {
        rangeSlider.minimumValue = minRange
        rangeSlider.maximumValue = maxRange
        maxValueLabel.text = String(format: "%.0f", maxRange)
        minValueLabel.text = String(format: "%.0f", minRange)
        currentValueLabel.text = String(format: "%.0f", minRange)
    }
}

// IBAction Methods
private extension RatingSelectionViewController {
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        currentValueLabel.text = String(format: "%.0f", rangeSlider.value)
    }
    
    @IBAction func didTapOnSubmitButton(_ sender: UIButton) {
        dataBase.save(rating: Int(rangeSlider.value))
        rangeSlider.value = 0
        currentValueLabel.text = "0"
    }
}
