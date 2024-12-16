//
//  TitleWithSubtitleTableViewCell.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.
//

import UIKit

class TitleWithSubtitleTableViewCell: UITableViewCell {
    static let identifier = "TitleWithSubtitleTableViewCell"
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FontSizes.mediumTitle, weight: .regular)
        label.textColor = FontColors.defaultDarkTextTitleColor
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FontSizes.mediumTitle, weight: .regular)
        label.textColor = FontColors.defaultValueColor
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = UIConstants.defaultHorizontalStackSpace
        return stackView
    }()
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    private func setupConstraints() {
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
    
    func configure(with model: BottomSheetModel) {
        titleLabel.text = model.title
        valueLabel.text = model.value
    }
}
