//
//  PeopleListCell.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import UIKit

public protocol PeopleListCellDelegate: class {
    func didDeleteButtonTap(cell: PeopleListCell)
}

public class PeopleListCell: UITableViewCell {
    @IBOutlet private weak var fieldsStackView: UIStackView!
    @IBOutlet private weak var deleteButton: UIButton!
    
    public weak var delegate: PeopleListCellDelegate?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        fieldsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    public func configure(viewModel: PeopleListCellViewModel) {
        viewModel.fields.forEach { key, value in
            let label = UILabel()
            label.text = "\(key): \(value)"
            fieldsStackView.addArrangedSubview(label)
        }
    }
    
    @IBAction private func deleteButtonTap() {
        delegate?.didDeleteButtonTap(cell: self)
    }
}
