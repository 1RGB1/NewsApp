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
    
    var topHeadlines: TopHeadlinesModel?
    var filterResult: TopHeadlinesModel?
    var sources = [SourcesModel]()
    var searchKeyword = ""
    
    var page = 1
    var searchPage = 1
    
    var isFirstTimeLoad = true
    var isInFilterMode = false
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News App"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
        
        initTableView()
        getTopHeadlines()
    }
    
    // MARK: - Functions
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
}

// MARK: Extensions
extension NewsListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0

        if isInFilterMode {
            if let model = filterResult, let articles = model.articles {
                count = articles.count
            }
        } else {
            if let model = topHeadlines, let articles = model.articles {
                count = articles.count
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var article: ArticleModel?
        if let model = topHeadlines, let articles = model.articles,
            let fileredModel = filterResult, let filteredArticles = fileredModel.articles {
            article = (isInFilterMode) ? filteredArticles[indexPath.row] : articles[indexPath.row]
        }

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
//
//        detailsViewController.movieId = movieId
//        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        
    }
    
    func setFilteredList(_ model: TopHeadlinesModel?, _ error: String?) {
        
    }
    
    func setSourcesList(_ model: SourcesModel?, _ error: String?) {
        
    }
    
//    func setNowPlayingMoviesList(_ model: SearchMoviesModel?, _ error: String?) {
//        if let searchMoviesModel = model, let newMovies = searchMoviesModel.results, let allPages = searchMoviesModel.total_pages {
//
//            if isFirstTimeLoad {
//                Utilities.showProgressHUDWithSuccess("Success")
//                isFirstTimeLoad = false
//            }
//
//            moviesListTableView.infiniteScrollingView.stopAnimating()
//
//            movies.append(contentsOf: newMovies)
//            page += 1
//            maxPagesCount = allPages
//
//            moviesListTableView.reloadData()
//            moviesListTableView.showsInfiniteScrolling = (page <= maxPagesCount)
//        } else {
//            if isFirstTimeLoad {
//                Utilities.showProgressHUDWithError(error ?? "")
//                isFirstTimeLoad = false
//            }
//
//            moviesListTableView.infiniteScrollingView.stopAnimating()
//            moviesListTableView.showsInfiniteScrolling = false
//        }
//    }
    
//    func setSearchMoviesList(_ model: SearchMoviesModel?, _ error: String?) {
//        if let searchMoviesModel = model, let newMovies = searchMoviesModel.results, let allPages = searchMoviesModel.total_pages {
//
//            moviesListTableView.infiniteScrollingView.stopAnimating()
//
//            searchResult.append(contentsOf: newMovies)
//            searchPage += 1
//            maxSearchPages = allPages
//
//            moviesListTableView.reloadData()
//            moviesListTableView.showsInfiniteScrolling = (searchPage <= maxSearchPages)
//        } else {
//
//            moviesListTableView.infiniteScrollingView.stopAnimating()
//            moviesListTableView.showsInfiniteScrolling = false
//        }
//    }
}
