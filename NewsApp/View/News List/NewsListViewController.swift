//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit
import SVPullToRefreshImprove

class NewsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    // MARK: - Properties
    let newsListViewModel = NewsListViewModel()
    
    var topHeadlines = [ArticleModel]()
    var filterResult = [ArticleModel]()
    var sources = [SourcesModel]()
    var searchKeyword = ""
    var page = 1
    
    var isFirstTimeLoad = true
    var isInFilterMode = false
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        
        newsListViewModel.delegate = self
        
        initTableView()
        getTopHeadlines()
    }
    
    // MARK: - Functions
    func setTitle() {
        self.title = "News App"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
    }
    
    func initTableView() {
        newsListTableView.delegate = self
        newsListTableView.dataSource = self
        handleLoadMore()
    }
    
    func handleLoadMore() {
        newsListTableView.addInfiniteScrolling { [weak self] in
            if (self?.isInFilterMode ?? false) {
                self?.getFilteredHeadlines()
            } else {
                self?.getTopHeadlines()
            }
        }
    }
    
    func getTopHeadlines() {
        if isFirstTimeLoad {
            Utilities.showProgressHUD()
        }
    
        newsListViewModel.getTopHeadlinesListWithPage(page)
    }
    
    func getFilteredHeadlines() {
//        newsListViewModel.getFilteredHeadlinesByPage(page, andFilterQuery: .source, andQuery: searchKeyword)
    }
    
    // MARK: - Outlet Functions
    @IBAction func filteButtonPressed(_ sender: Any) {
    }
}

// MARK: Extensions
extension NewsListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var count = 0
        
        if isInFilterMode {
            count = filterResult.count
        } else {
            count = topHeadlines.count
        }
        
        if count == 0 {
            noDataFoundLabel.isHidden = false
            if !isFirstTimeLoad {
                noDataFoundLabel.text = "No Data Found"
            }
            newsListTableView.isHidden = true
        } else {
            noDataFoundLabel.isHidden = true
            noDataFoundLabel.text = ""
            newsListTableView.isHidden = false
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as! HeadlineTableViewCell
        
        let article = (isInFilterMode) ? filterResult[indexPath.row] : topHeadlines[indexPath.row]
        cell.setModel(article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = (isInFilterMode) ? filterResult[indexPath.row] : topHeadlines[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let articleDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController

        articleDetailsViewController.article = article
        self.navigationController?.pushViewController(articleDetailsViewController, animated: true)
    }
}

extension NewsListViewController : UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        handleLoadMore()
//        searchResult.removeAll()
//        searchPage = 1
//        maxSearchPages = 1
//
//        if searchText.count >= 4 {
//            isInSearchMode = true
//            searchKeyword = searchText
//            movieListViewModel.getMoviesBySearchWith(searchPage, andKeyword: searchKeyword)
//            moviesListTableView.separatorStyle = .singleLine
//        } else {
//            isInSearchMode = false
//            moviesListTableView.separatorStyle = .none
//            moviesListTableView.reloadData()
//        }
//    }
}

extension NewsListViewController : NewsListViewModelDelegate {
    func setTopHeadlinesList(_ model: TopHeadlinesModel?, _ error: String?) {
        if let topHeadlinesModel = model, let articles = topHeadlinesModel.articles, let total = topHeadlinesModel.totalResults {
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithSuccess("Success")
                isFirstTimeLoad = false
            }
            
            newsListTableView.infiniteScrollingView.stopAnimating()
            
            topHeadlines.append(contentsOf: articles)
            page += 1
            
            newsListTableView.reloadData()
            newsListTableView.showsInfiniteScrolling = (page <= total)
        } else {
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithError(error ?? "")
                isFirstTimeLoad = false
            }
            
            newsListTableView.infiniteScrollingView.stopAnimating()
            newsListTableView.showsInfiniteScrolling = false
        }
    }
    
    func setFilteredList(_ model: TopHeadlinesModel?, _ error: String?) {
//        if let topHeadlinesModel = model, let articles = topHeadlinesModel.articles, let total = topHeadlinesModel.totalResults {
//            if isFirstTimeLoad {
//                Utilities.showProgressHUDWithSuccess("Success")
//                isFirstTimeLoad = false
//            }
//            
//            newsListTableView.infiniteScrollingView.stopAnimating()
//            
//            filterResult.append(contentsOf: articles)
//            page += 1
//            
//            newsListTableView.reloadData()
//            newsListTableView.showsInfiniteScrolling = (page <= total)
//        } else {
//            if isFirstTimeLoad {
//                Utilities.showProgressHUDWithError(error ?? "")
//                isFirstTimeLoad = false
//            }
//            
//            newsListTableView.infiniteScrollingView.stopAnimating()
//            newsListTableView.showsInfiniteScrolling = false
//        }
    }
    
    func setSourcesList(_ model: SourcesModel?, _ error: String?) {
        
    }
}
