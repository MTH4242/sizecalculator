//
//  SavedUsersVC.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/25/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

protocol SavedUsersVCDelegate: class {
    func savedUsersVC(_ controller: SavedUsersVC, didSelectSavedSize size: (username: String, size: Size))
}

class SavedUsersVC: UIViewController {
    
    weak var delegate: SavedUsersVCDelegate?
    
    private let contentView = SavedUsersView()
    private var sizes: [(username: String, size: Size)] = []
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        let defaults = UserDefaults.standard
        guard let sizes = defaults.dictionary(forKey: "sizes") as? [String: Int] else { return }
        self.sizes = sizes.map { return ($0.key, Size(rawValue: $0.value)!) }
    }
}

extension SavedUsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = sizes[indexPath.row].username
        cell.detailTextLabel?.text = sizes[indexPath.row].size.displayName
        return cell
    }
}

extension SavedUsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.savedUsersVC(self, didSelectSavedSize: sizes[indexPath.row])
    }
}
