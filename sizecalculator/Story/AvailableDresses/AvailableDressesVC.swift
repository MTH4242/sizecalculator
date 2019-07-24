//
//  AvailableDressesVC.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/24/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

class AvailableDressesVC: UIViewController {
    
    private let contentView = AvailableDressesView()
    
    private let size: Size
    private var dresses: [Dress] = []
    
    init(size: Size) {
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchDresses()
        dresses.forEach { print($0.name) }
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    private func fetchDresses() {
        do {
            if let dressesURL = Bundle.main.url(forResource: "dresses", withExtension: "json") {
                let dressesJSONData = try Data(contentsOf: dressesURL)
                self.dresses = try JSONDecoder().decode([Dress].self, from: dressesJSONData)
            }
        } catch {
            showErrorAlert(title: error.localizedDescription)
        }
    }
}

extension AvailableDressesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
