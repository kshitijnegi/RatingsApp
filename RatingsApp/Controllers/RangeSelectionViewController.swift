//
//  RangeSelectionViewController.swift
//  RatingsApp
//
//  Created by Kshitij Negi on 17/04/20.
//  Copyright © 2020 Kshitij Negi. All rights reserved.
//

import UIKit

final class RangeSelectionViewController: UIViewController  {
    
    @IBOutlet private weak var minRangeInputField: UITextField!
    @IBOutlet private weak var maxRangeInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGestureToHideKeyBoard()
    }
    
    
    
    
    
    
}

// Private Methods
private extension RangeSelectionViewController {
    func configureTapGestureToHideKeyBoard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RatingSelectionViewController") as! RatingSelectionViewController
        vc.allowedRange(min: Float(minRangeInputField.text!) ?? 0,
                        max: Float(maxRangeInputField.text!) ?? 10)
        self.present(vc, animated: true, completion: nil)
    }
}

// IBAction Methods
private extension RangeSelectionViewController {
    
    @IBAction func didTapOnSubmitButton(_ sender: UIButton) {
        
        if minRangeInputField.text?.count  == 0 {
            showAlert(message: "Minimum range can't be empty")
            return
        }
        if maxRangeInputField.text?.count == 0 {
            showAlert(message: "Maximum range can't be empty")
            return
        }
        
        if let value1 = minRangeInputField.text, let convertedVal = Int(value1) {
            if convertedVal >= 0 && convertedVal <= 9 {
                if let value2 = maxRangeInputField.text,  let convertedVal = Int(value2) {
                    if convertedVal >= 0 && convertedVal <= 9 {
                        pushViewController()
                    } else {
                        showAlert(message: "Range should be between 0 to 9")
                    }
                }
            } else {
                showAlert(message: "Range should be between 0 to 9")
            }
        }
    }
    
    @IBAction func didTapOnRatingsHistoryButton(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryRatingsViewController") as! HistoryRatingsViewController
        self.present(vc, animated: true, completion: nil)

    }
}
