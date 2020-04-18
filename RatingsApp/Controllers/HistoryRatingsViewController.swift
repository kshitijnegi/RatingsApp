//
//  HIstoryRatingsViewController.swift
//  RatingsApp
//
//  Created by Kshitij Negi on 18/04/20.
//  Copyright © 2020 Kshitij Negi. All rights reserved.
//

import UIKit

final class HistoryRatingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var savedRatings = [Rating]()
    private lazy var dataBase = DataBaseHelper()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromDb()
    }
}

// Private methods
extension HistoryRatingsViewController {
    func fetchDataFromDb() {
        savedRatings = dataBase.savedRatings()
    }
}

// IBAction Methods
extension HistoryRatingsViewController {
    @IBAction func didTapOnExitScreenButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// TableView DataSource and Delegate Methods
extension HistoryRatingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRatings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsHistoryTableViewCell",
                                                 for: indexPath) as! RatingsHistoryTableViewCell
        let rating = savedRatings[indexPath.row].rating
        let formattedDate = dateFormatter.string(from: savedRatings[indexPath.row].savedTime!)
        cell.configureCell(rating: "\(rating)", date: formattedDate)
        return cell
    }
}
