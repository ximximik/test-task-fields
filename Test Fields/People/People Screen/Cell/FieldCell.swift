//
//  FieldCell.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import UIKit

public protocol FieldCellDelegate: class {
    func fieldValueDidChange(newValue: String, cell: FieldCell)
}

public class FieldCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    private var viewModel: FieldCellViewModel!
    
    public weak var delegate: FieldCellDelegate?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        textField.text = ""
    }
    
    public func configure(viewModel: FieldCellViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        textField.text = viewModel.value
        
        titleLabel.textColor = viewModel.isInvalidate ? .red : .black
        textField.textColor = viewModel.isInvalidate ? .red : .black
        
        switch viewModel.type {
        case .number:
            textField.keyboardType = .numberPad
            textField.inputView = nil
        case .string:
            textField.keyboardType = .default
            textField.inputView = nil
        case .date:
            textField.keyboardType = .default
            textField.setInputViewDatePicker(target: self,
                                             selector: #selector(datePickerFinished),
                                             defaultValue: viewModel.value.date(with: initData.dateFormat))
        }
    }
    
    
    @objc private func datePickerFinished() {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = initData.dateFormat
            textField.text = dateFormatter.string(from: datePicker.date)
            didChangeFieldValue()
        }
        textField.resignFirstResponder()
    }
    
    @IBAction private func didChangeFieldValue() {
        delegate?.fieldValueDidChange(newValue: textField.text ?? "", cell: self)
    }
    
}

extension FieldCell: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLabel.textColor = .black
        textField.textColor = .black
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
