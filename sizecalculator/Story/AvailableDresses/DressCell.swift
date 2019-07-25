//
//  DressCell.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/24/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

protocol DressCellDelegate: class {
    func dressCellDidAddDress(_ dressCell: DressCell)
}

class DressCell: UITableViewCell {
    
    weak var delegate: DressCellDelegate?
    
    static let reuseIdentifier = "\(DressCell.self)"
    
    private let colorView = UIView()
    private let nameLabel = UILabel()
    private let categoryLabel = UILabel()
    private let addToCartButton = UIButton()
    private let sizeLabel = UILabel()
    private let statusView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        contentView.addSubview(colorView)
        colorView.layer.cornerRadius = 8
        colorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(colorView.snp.height)
        }
        
        contentView.addSubview(statusView)
        statusView.layer.cornerRadius = 10
        statusView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(20)
        }
        
        contentView.addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(statusView.snp.leading).offset(-16)
        }
        
        contentView.addSubview(addToCartButton)
        addToCartButton.backgroundColor = .blue
        addToCartButton.layer.cornerRadius = 20
        addToCartButton.setTitle("Add", for: .normal)
        addToCartButton.onTap {
            self.delegate?.dressCellDidAddDress(self)
        }
        addToCartButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(sizeLabel.snp.leading).offset(-16)
        }
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel])
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.greaterThanOrEqualTo(addToCartButton.snp.leading).offset(-16).priority(.low)
        }
    }
    
    func update(withDress dress: Dress) {
        switch dress.color {
        case .red:
            colorView.backgroundColor = .red
        case .green:
            colorView.backgroundColor = .green
        case .blue:
            colorView.backgroundColor = .blue
        case .black:
            colorView.backgroundColor = .black
        case .orange:
            colorView.backgroundColor = .orange
        case .purple:
            colorView.backgroundColor = .purple
        }
        
        nameLabel.text = dress.name
        categoryLabel.text = dress.category.name
        sizeLabel.text = dress.size.displayName
        switch dress.status {
        case .inStock:
            statusView.backgroundColor = .green
        case .inProduction:
            statusView.backgroundColor = .orange
        case .forwardOrder:
            statusView.backgroundColor = .blue
        }
    }
}
