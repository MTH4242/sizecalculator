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
    private let category: Dress.Category
    private var dresses: [Dress] = []
    private var filteredDresses: [Dress] = []
    
    private func filterDresses(withSearchText text: String?) {
        filteredDresses = dresses.filter {
            $0.size == size &&
            $0.category == $0.category &&
            $0.status != .forwardOrder
        }
        if text != nil && !text!.isEmpty {
            filteredDresses = filteredDresses.filter { $0.name.contains(text!) }
        }
    }
    
    init(size: Size, category: Dress.Category) {
        self.size = size
        self.category = category
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
        setupNavigationBar()
        setupTableView()
        fetchDresses()
        filterDresses(withSearchText: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "\(category.name), \(size.name), \(size.displayName)"
    }
    
    private func setupTableView() {
        contentView.tableView.register(DressCell.self, forCellReuseIdentifier: DressCell.reuseIdentifier)
        contentView.tableView.dataSource = self
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type to search by name"
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
        filterDresses(withSearchText: searchController.searchBar.text)
        contentView.tableView.reloadData()
    }
}

extension AvailableDressesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DressCell.reuseIdentifier, for: indexPath) as! DressCell
        cell.update(withDress: filteredDresses[indexPath.row])
        return cell
    }
}
