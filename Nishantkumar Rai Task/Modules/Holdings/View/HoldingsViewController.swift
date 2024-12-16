//
//  HoldingsViewController.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//

import UIKit

protocol HoldingsViewProtocol: AnyObject {
    func showHoldings(_ holdings: [UserHoldings])
    func showError(_ errorMessage: String)
    func showHoldingsSumary(holdingsSummary: [BottomSheetModel], totalPNLTitle: String, totalPNL: String)
    func shouldShowHoldingSummaryView(_ shouldShow: Bool)
}

class HoldingsViewController: UIViewController {
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
    
    private let imgView: UIImageView = {
        let imageView = UIImageView(image: ImageAssets.upArrow)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray5
        view.applyCornerRadius(UIConstants.defaultCornerRadius)
        return view
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
    var presenter: HoldingsPresenterProtocol?
    let tableView = UITableView()
    var holdings = [UserHoldings]()
    var holdingsSummary = [BottomSheetModel]()
    let holdingsSummaryView = HoldingsSummaryBottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter?.loadHoldings()
    }
    
    func setupUI() {
        title = LabelText.holdingsTitle
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(HoldingsTableViewCell.self, forCellReuseIdentifier: HoldingsTableViewCell.identifier)
        view.addSubview(tableView)
        view.addSubview(containerView)
        view.addSubview(holdingsSummaryView)
        containerView.addSubview(stackView)
        holdingsSummaryView.translatesAutoresizingMaskIntoConstraints = false
        holdingsSummaryView.backgroundColor = UIColor.systemGray5
        holdingsSummaryView.isHidden = true
        
        let bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = UIConstants.defaultHorizontalStackSpace
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .fill
        bottomStackView.addArrangedSubview(titleLabel)
        bottomStackView.addArrangedSubview(imgView)
    
        stackView.addArrangedSubview(bottomStackView)
        stackView.addArrangedSubview(valueLabel)
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnHondingSumaryView(_:))))
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraint for botto container view
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 70.0),
            
            // Constraint for stack view
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -UIConstants.defaultTopSpace),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIConstants.defaultLeadingSpace),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -UIConstants.defaultTrailingSpace),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -UIConstants.defaultBottomSpace),
            
            // Constraint for Holdings summary view
            holdingsSummaryView.bottomAnchor.constraint(equalTo: self.containerView.topAnchor),
            holdingsSummaryView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            holdingsSummaryView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            holdingsSummaryView.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
    
    @objc
    func didTapOnHondingSumaryView(_ sender: UITapGestureRecognizer) {
        presenter?.didTapOnHoldingSummaryView()
    }
}

extension HoldingsViewController: HoldingsViewProtocol {
    
    func shouldShowHoldingSummaryView(_ shouldShow: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.holdingsSummaryView.alpha = shouldShow ? 1.0 : 0.0
            self.holdingsSummaryView.isHidden = !shouldShow
            if shouldShow {
                self.holdingsSummaryView.configure(with: self.holdingsSummary)
            }
            self.imgView.image = shouldShow ? ImageAssets.downArrow : ImageAssets.upArrow
        }
    }
    
    func showHoldings(_ holdings: [UserHoldings]) {
        self.holdings = holdings
        tableView.reloadData()
        imgView.isHidden = false
    }
    
    func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showHoldingsSumary(holdingsSummary: [BottomSheetModel], totalPNLTitle: String, totalPNL: String) {
        self.holdingsSummary = holdingsSummary
        titleLabel.attributedText = CommonUtils.getTextWithAsterisk(to: totalPNLTitle)
        valueLabel.text = totalPNL
    }
}

extension HoldingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holdings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingsTableViewCell.identifier, for: indexPath) as? HoldingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: holdings[indexPath.row])
        return cell
    }
}
