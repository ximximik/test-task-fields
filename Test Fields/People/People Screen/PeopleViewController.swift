//
//  PeopleViewController.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import UIKit

public class PeopleViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    // Для тестового проекта использую синглтоны вместо DI
    public var viewModel: PeopleViewModel! = PeopleViewModel(scheme: initData.scheme, dataManager: peopleDataManager)
    
    private var fields: [FieldCellViewModel] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.updateData()
        }
    }
    
    public func setupBindings() {
        viewModel.dataDidUpdated = { [unowned self] data in
            self.fields = data
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
    }
    
// MARK: Actions
    
    @IBAction private func saveButtonTap() {
        viewModel.validateAndSave()
        view.endEditing(true)
    }
}

// MARK: - UITableView
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    private typealias CellType = FieldCell
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let field = fields[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.describing, for: indexPath) as! CellType
        cell.delegate = self
        cell.configure(viewModel: field)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FieldCellDelegate
extension PeopleViewController: FieldCellDelegate {
    public func fieldValueDidChange(newValue: String, cell: FieldCell) {
        if let index = tableView.indexPath(for: cell)?.row {
            viewModel.updateField(at: index, value: newValue)
        }
    }
}
