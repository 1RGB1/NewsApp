//
//  NewsFeedDetailsViewController.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import UIKit

class NewsFeedDetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    var viewModel: NewsFeedDetailsViewModelProtocol?
    var cellsViewModel: [BaseCellViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed Details"
        cellsViewModel = viewModel?.getCellsViewModel()
        prepTableView()
    }
    
    fileprivate func prepTableView() {
        registerCells()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    fileprivate func registerCells() {
        guard let viewModels = cellsViewModel else { return }
        
        for viewModel in viewModels {
            detailsTableView.registerCell(viewModel.type)
        }
    }
}

extension NewsFeedDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModels = cellsViewModel else { return UITableViewCell() }
        
        let viewModel = viewModels[indexPath.row]
        guard let cell = detailsTableView.dequeueReusableCell(viewModel.type, for: indexPath) as? CellConfigurable else { return UITableViewCell() }
        
        cell.setUp(model: viewModel)
        
        if let actionCell = cell as? ActionKeyValueTableViewCell {
            actionCell.delegate = self
        }
        
        return cell
    }
}

extension NewsFeedDetailsViewController: ActionKeyValueTableViewCellDelegate {
    func didTapNavigateURL(_ url: URL) {
        presentSFSafariViewControllerFor(url: url)
    }
}
