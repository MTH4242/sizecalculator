//
//  AvailableDressesView.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/24/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

class AvailableDressesView: UIView {
    
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
        tableView.allowsSelection = false
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
