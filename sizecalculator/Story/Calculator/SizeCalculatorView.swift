//
//  SizeCalculatorView.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit
import SnapKit
import Closures
import DropDown

protocol SizeCalculatorViewDelegate: class {
    func didSelectUnit(_ unit: UnitLength)
    func didTapCalculate()
    func didTapShowAvailableDresses()
    func didChangeCategory(_ category: Dress.Category)
    func didTapShowUsers()
    func didTapSaveUsername()
}

final class SizeCalculatorView: UIView {
    private let centimetersButton = UIButton.selectionStyled
    private let inchesButton = UIButton.selectionStyled
    private let calculateButton = UIButton()
    private let showDressesButton = UIButton(type: .system)
    
    private let categoryButton = UIButton(type: .system)
    private let categoryDropDown = DropDown()
    
    private let showUsersButton = UIButton(type: .system)
    private let saveUsernameButton = UIButton(type: .system)
    
    let bustTextField = UITextField()
    let waistTextField = UITextField()
    let hipTextField = UITextField()
    let usernameTextField = UITextField()
    
    let textView = UITextView()
    
    var bust: Double {
        let text = bustTextField.text ?? ""
        return Double(text) ?? 0.0
    }
    var waist: Double {
        let text = waistTextField.text ?? ""
        return Double(text) ?? 0.0
    }
    var hips: Double {
        let text = hipTextField.text ?? ""
        return Double(text) ?? 0.0
    }
    
    weak var delegate: SizeCalculatorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        let width = (UIScreen.main.bounds.width * 0.3).rounded()
        containerView.addSubview(centimetersButton)
        centimetersButton.isSelected = true
        centimetersButton.setTitle("CM", for: .normal)
        centimetersButton.onTap { [unowned self] in
            guard !self.centimetersButton.isSelected else { return }
            self.inchesButton.isSelected.toggle()
            self.centimetersButton.isSelected.toggle()
            self.delegate?.didSelectUnit(.centimeters)
            self.textView.text = ""
        }
        centimetersButton.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(44)
            $0.top.leading.bottom.equalToSuperview()
        }
        
        containerView.addSubview(inchesButton)
        inchesButton.setTitle("Inches", for: .normal)
        inchesButton.onTap { [unowned self] in
            guard !self.inchesButton.isSelected else { return }
            self.centimetersButton.isSelected.toggle()
            self.inchesButton.isSelected.toggle()
            self.delegate?.didSelectUnit(.inches)
            self.textView.text = ""
        }
        inchesButton.snp.makeConstraints {
            $0.width.height.equalTo(centimetersButton)
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(centimetersButton.snp.trailing).offset(20)
        }
        
        
        bustTextField.placeholder = MeasurementInputType.bust.rawValue
        bustTextField.keyboardType = .decimalPad
        bustTextField.borderStyle = .roundedRect
        waistTextField.placeholder = MeasurementInputType.waist.rawValue
        waistTextField.keyboardType = .decimalPad
        waistTextField.borderStyle = .roundedRect
        hipTextField.placeholder = MeasurementInputType.hips.rawValue
        hipTextField.keyboardType = .decimalPad
        hipTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        
        let stackView = UIStackView(arrangedSubviews: [bustTextField,
                                                       waistTextField,
                                                       hipTextField,
                                                       usernameTextField])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        addSubview(categoryButton)
        categoryButton.setTitle(Dress.Category.evening.name, for: .normal)
        categoryButton.onTap { [weak self] in
            self?.categoryDropDown.show()
        }
        categoryButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(20)
            $0.top.equalTo(containerView.snp.bottom).offset(40)
        }
        
        categoryDropDown.anchorView = categoryButton
        categoryDropDown.dataSource = Dress.Category.allCases.map { $0.name }
        categoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.categoryButton.setTitle(item, for: .normal)
            guard let category = Dress.Category(name: item) else { return }
            self?.delegate?.didChangeCategory(category)
        }
        
        addSubview(showUsersButton)
        showUsersButton.setTitle("Show Users", for: .normal)
        showUsersButton.onTap { [weak self] in
            self?.delegate?.didTapShowUsers()
        }
        showUsersButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(20)
            $0.top.equalTo(categoryButton.snp.bottom).offset(16)
        }
        
        addSubview(saveUsernameButton)
        saveUsernameButton.setTitle("Save Size for User", for: .normal)
        saveUsernameButton.onTap { [weak self] in
            self?.delegate?.didTapSaveUsername()
        }
        
        saveUsernameButton.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(20)
            $0.top.equalTo(showUsersButton.snp.bottom).offset(16)
        }
        
        addSubview(calculateButton)
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 10
        let calculateBgImage = UIImage.image(from: UIColor.green.withAlphaComponent(0.7))
        let calculateBgHighlightedImage = UIImage.image(from: UIColor.green.withAlphaComponent(0.4))
        calculateButton.setBackgroundImage(calculateBgImage, for: .normal)
        calculateButton.setBackgroundImage(calculateBgHighlightedImage, for: .highlighted)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.onTap { [unowned self] in
            self.delegate?.didTapCalculate()
        }
        calculateButton.snp.makeConstraints {
            $0.height.equalTo(centimetersButton)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        addSubview(showDressesButton)
        showDressesButton.setTitle("Show Available Dresses", for: .normal)
        showDressesButton.isHidden = true
        showDressesButton.onTap { [weak self] in
            self?.delegate?.didTapShowAvailableDresses()
        }
        showDressesButton.snp.makeConstraints {
            $0.top.equalTo(calculateButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(textView)
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.snp.makeConstraints {
            $0.top.equalTo(showDressesButton.snp.bottom).offset(20)
            $0.leading.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    func updateResults(size: Size) {
        textView.text = """
            Your Size is: \(size.name)
            Your UK Size is: \(size.UK)
            Your EU Size is: \(size.EU)
            Your US Size is: \(size.US)
        """
        showDressesButton.isHidden = false
    }
}
