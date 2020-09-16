//
//  PeopleListViewController.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import UIKit

public class PeopleListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    // Для тестового проекта использую синглтоны вместо DI
    public var viewModel: PeopleListViewModel! = PeopleListViewModel(scheme: initData.scheme, dataManager: peopleDataManager)
    
    private var peoples: [PeopleListCellViewModel] = []
    
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
            self.peoples = data
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func presentPeople(at index: Int) {
        if let vc = UIStoryboard(name: "People", bundle: nil).instantiateViewController(identifier: PeopleViewController.describing) as? PeopleViewController {
            vc.viewModel.configure(peopleIndex: index)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableView
extension PeopleListViewController: UITableViewDataSource, UITableViewDelegate {
    private typealias CellType = PeopleListCell
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let people = peoples[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.describing, for: indexPath) as! CellType
        cell.configure(viewModel: people)
        cell.delegate = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentPeople(at: indexPath.row)
    }
}

// MARK: - PeopleListCellDelegate
extension PeopleListViewController: PeopleListCellDelegate {
    public func didDeleteButtonTap(cell: PeopleListCell) {
        if let index = tableView.indexPath(for: cell)?.row {
            viewModel.deletePeople(at: index)
        }
    }
}
