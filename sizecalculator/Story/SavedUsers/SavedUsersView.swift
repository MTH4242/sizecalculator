//
//  SavedUsersView.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/25/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

class SavedUsersView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.rowHeight = 80
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
