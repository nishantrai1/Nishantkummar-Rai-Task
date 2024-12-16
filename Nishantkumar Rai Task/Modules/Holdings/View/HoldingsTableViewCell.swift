//
//  HoldingsTableViewCell.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//

import UIKit

class HoldingsTableViewCell: UITableViewCell {
    static let identifier = "HoldingsTableViewCell"
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FontSizes.largeTitle, weight: .medium)
        return label
    }()
    
    private let qtyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ltpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FontSizes.regularTitle, weight: .regular)
        return label
    }()
    
    private let profitAndLossLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FontSizes.regularTitle, weight: .regular)
        return label
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIConstants.defaultVerticalStackSpace
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
   
    func setupUI() {
        contentView.addSubview(stackView)
        
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.spacing = UIConstants.defaultHorizontalStackSpace
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.addArrangedSubview(symbolLabel)
        topStackView.addArrangedSubview(ltpLabel)
        
        let bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = UIConstants.defaultHorizontalStackSpace
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .fill
        bottomStackView.addArrangedSubview(qtyLabel)
        bottomStackView.addArrangedSubview(profitAndLossLabel)
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.defaultTopSpace),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.defaultBottomSpace),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.defaultLeadingSpace),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.defaultTrailingSpace)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(label: UILabel, with title: String, value: String, titleFontSize: CGFloat = FontSizes.regularTitle, titleFontWeight: UIFont.Weight = .regular, valueFontSize: CGFloat = FontSizes.mediumTitle, valueFontWeight: UIFont.Weight = .regular, titleTextColor: UIColor = FontColors.defaultTitleColor, valueTextColor: UIColor = FontColors.defaultValueColor) {
        
        let fullText = title + value
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let titleRange = (fullText as NSString).range(of: title)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: titleFontSize, weight: titleFontWeight), range: titleRange)
        attributedText.addAttribute(.foregroundColor, value: titleTextColor, range: titleRange)
        
        let valueRange = (fullText as NSString).range(of: value)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: valueFontSize, weight: valueFontWeight), range: valueRange)
        attributedText.addAttribute(.foregroundColor, value: valueTextColor, range: valueRange)
        
        label.attributedText = attributedText
    }
    
    func configure(with userHoldings: UserHoldings) {
        symbolLabel.text = userHoldings.symbol
        configure(label: qtyLabel, with: LabelText.netQty, value: "\(userHoldings.quantity)")
        configure(label: ltpLabel, with: LabelText.ltp, value: LabelText.rupeeSymbol + "\(userHoldings.ltp)")
        configure(label: profitAndLossLabel, with: LabelText.profitAndLoss, value: userHoldings.pnl, valueTextColor: userHoldings.pnlColor)
    }
}
