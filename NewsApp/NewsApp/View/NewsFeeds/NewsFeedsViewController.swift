//
//  NewsFeedsViewController.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import UIKit
import ProgressHUD
import UIScrollView_InfiniteScroll

class NewsFeedsViewController: UIViewController {

    @IBOutlet weak var newsFeedsSearchBar: UISearchBar!
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var viewModel = NewsFeedViewModel()
    var isSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        prepTableView()
        newsFeedsSearchBar.delegate = self
        newsFeedsSearchBar.searchTextField.delegate = self
    }
    
    fileprivate func prepTableView() {
        newsFeedTableView.registerCell(NewsFeedTableViewCell.self)
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        
        newsFeedTableView.addInfiniteScroll { [weak self] (tableView) in
            guard let self = self else { return }
            self.viewModel.currentPage += 1
            self.isSearching = false
            self.loadData()
        }
    }
    
    @objc
    fileprivate func loadData() {
        if isSearching { ProgressHUD.show(icon: .bolt) }
        viewModel.loadNewsFeedsPage() { [weak self] in
            guard let self = self else { return }
            if self.isSearching { ProgressHUD.dismiss() }
            self.newsFeedTableView.reloadData()
            self.newsFeedTableView.finishInfiniteScroll()
        } withFailureBlock: { errorString in
            ProgressHUD.showError(errorString, image: nil, interaction: true)
            self.newsFeedTableView.finishInfiniteScroll()
        }
    }
}

extension NewsFeedsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension NewsFeedsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        viewModel.currentPage = 1
        isSearching = true
        loadData()
        return true
    }
}

extension NewsFeedsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.query = searchText
        viewModel.currentPage = 1
        isSearching = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(loadData), object: nil)
        self.perform(#selector(loadData), with: nil, afterDelay: 1)
    }
}

extension NewsFeedsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellsViewModels[indexPath.row]
        guard let cell = newsFeedTableView.dequeueReusableCell(cellViewModel.type, for: indexPath) as? CellConfigurable else { return UITableViewCell() }
        cell.setUp(model: cellViewModel)
        return cell
    }
}
