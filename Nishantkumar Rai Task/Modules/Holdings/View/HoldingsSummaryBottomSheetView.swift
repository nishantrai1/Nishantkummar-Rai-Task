//
//  HoldingsSummaryBottomSheetView.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.
//

import UIKit

class HoldingsSummaryBottomSheetView: UIView {
    private let tableView = UITableView()
    var model = [BottomSheetModel]()
    
    private func setupUI() {
        self.backgroundColor = UIColor.systemGray5
        self.applyCornerRadius(UIConstants.defaultCornerRadius)
        self.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(TitleWithSubtitleTableViewCell.self, forCellReuseIdentifier: TitleWithSubtitleTableViewCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: [BottomSheetModel]) {
        self.model = model
        tableView.frame = self.bounds
        tableView.reloadData()
    }
}

extension HoldingsSummaryBottomSheetView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithSubtitleTableViewCell.identifier, for: indexPath) as? TitleWithSubtitleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    
}
