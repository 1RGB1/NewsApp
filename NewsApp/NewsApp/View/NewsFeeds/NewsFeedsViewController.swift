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
        configureProgress()
        prepSearchBar()
        prepTableView()
    }
    
    fileprivate func configureProgress() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorHUD = .systemGray
        ProgressHUD.colorBackground = .lightGray
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.fontStatus = UIFont(name: "HelveticaNeue-Regular", size: 18) ?? .boldSystemFont(ofSize: 18)
        
        let defaultImageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        if let successImage = UIImage(systemName: "checkmark.circle", withConfiguration: defaultImageConfiguration) {
            ProgressHUD.imageSuccess = successImage
        }
        if let faildImage = UIImage(systemName: "xmark.octagon", withConfiguration: defaultImageConfiguration) {
            ProgressHUD.imageError = faildImage
        }
    }
    
    fileprivate func prepSearchBar() {
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
        if isSearching { ProgressHUD.show() }
        viewModel.loadNewsFeedsPage() { [weak self] in
            guard let self = self else { return }
            if self.isSearching {
                ProgressHUD.dismiss()
                ProgressHUD.colorStatus = .systemBlue
                ProgressHUD.show(icon: .succeed)
            }
            self.newsFeedTableView.reloadData()
            self.newsFeedTableView.finishInfiniteScroll()
        } withFailureBlock: { errorString in
            ProgressHUD.colorStatus = .systemRed
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.cellsViewModels[indexPath.row]
        guard let newsFeedCellViewModel = cellViewModel as? NewsFeedCellViewModel else { return }
        let article = newsFeedCellViewModel.article
        let newsFeedDetailsViewModel = NewsFeedDetailsViewModel(article: article)
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "NewsFeedDetailsViewController") as? NewsFeedDetailsViewController else { return }
        detailsViewController.viewModel = newsFeedDetailsViewModel
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
