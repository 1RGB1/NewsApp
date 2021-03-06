//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit
import SVPullToRefreshImprove
import SnapKit

class NewsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    @IBOutlet weak var reloadLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    // MARK: - Properties
    let newsListViewModel = NewsListViewModel()
    let filterPopupViewModel = FilterPopupViewModel()
    var topHeadlines = [ArticleModel]()
    var filterResult = [ArticleModel]()
    var filterView: FilterView?
    var countries: [String]?
    var sources: [SourceModel]?
    var page = 1
    var filterQuery: FilterQuery = .none
    var query = ""
    var isFirstTimeLoad = true
    var isInFilterMode = false
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        newsListViewModel.delegate = self
        filterPopupViewModel.delegate = self
        
        initTableView()
        getTopHeadlines()
    }
    
    // MARK: - Functions
    func initUI() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        filterView = FilterView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        setTitle()
    }
    
    func setTitle() {
        self.title = "News"
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
        newsListViewModel.getFilteredHeadlinesByPage(page, andFilterQuery: self.filterQuery, andQuery: self.query)
    }
    
    func showFilterView() {
        
        filterButton.isEnabled = false
        filterView!.countries = self.countries
        filterView!.sources = self.sources
        filterView!.delegate = self
        
        self.view.addSubview(filterView!)
        
        filterView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        filterView!.configure()
        filterView!.initData()
    }
    
    func handleNoDataFound(showNoData: Bool) {
        noDataFoundLabel.isHidden = !showNoData
        noDataFoundLabel.text = showNoData ? "No Data Found" : ""
        reloadLabel.isHidden = !showNoData
        reloadButton.isHidden = !showNoData
        underlineView.isHidden = !showNoData
        newsListTableView.isHidden = showNoData
    }
    
    // MARK: - Outlet Functions
    @IBAction func filteButtonPressed(_ sender: Any) {
        
        if sources != nil && sources?.count != 0 {
            showFilterView()
            return
        }
        
        Utilities.showProgressHUD()
        filterPopupViewModel.getCountriesList()
        filterPopupViewModel.getSourcesList()
    }
    
    @IBAction func reloadDataButtonPressed(_ sender: Any) {
        isFirstTimeLoad = true
        
        if isInFilterMode {
            getFilteredHeadlines()
        } else {
            getTopHeadlines()
        }
    }
}

// MARK: Extensions
// Table View Delegate and DataSource
extension NewsListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isInFilterMode ? filterResult.count : topHeadlines.count
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

// News List Delegate
extension NewsListViewController : NewsListViewModelDelegate {
    
    func setTopHeadlinesList(_ model: TopHeadlinesModel?, forHeadlinesType type: Headlines, _ error: String?) {
        if let topHeadlinesModel = model, let articles = topHeadlinesModel.articles {
            if articles.count == 0 {
                if page == 1 {
                    handleNoDataFound(showNoData: true)
                } else {
                    handleNoDataFound(showNoData: false)
                }
            } else {
                handleNoDataFound(showNoData: false)
            }
            
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithSuccess("Success")
                isFirstTimeLoad = false
            }
            
            newsListTableView.infiniteScrollingView.stopAnimating()
            
            if type == .everything {
                topHeadlines.append(contentsOf: articles)
            } else {
                filterResult.append(contentsOf: articles)
            }
            page += 1
            
            newsListTableView.reloadData()
            
            if let total = topHeadlinesModel.totalResults {
                newsListTableView.showsInfiniteScrolling = (page <= total)
            }
        } else {
            if page == 1 {
                handleNoDataFound(showNoData: true)
            } else {
                handleNoDataFound(showNoData: false)
            }
            
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithError(error ?? "Opps, something went wrong")
                isFirstTimeLoad = false
            }
            
            newsListTableView.infiniteScrollingView.stopAnimating()
            newsListTableView.showsInfiniteScrolling = false
        }
    }
}

// Filter Popup View Model Delegate
extension NewsListViewController : FilterPopupViewModelDelegate {
    
    func setCountriesList(_ countries: [String]?, _ error: String?) {
        if let list = countries {
            self.countries = list
        } else {
            Utilities.showProgressHUDWithError(error ?? "")
        }
    }
    
    func setSourcesList(_ model: SourcesModel?, _ error: String?) {
        if let sourcesModel = model, let list = sourcesModel.sources {
            self.sources = list
            Utilities.showProgressHUDWithSuccess("Success")
            showFilterView()
        } else {
            Utilities.showProgressHUDWithError(error ?? "")
        }
    }
}

// Filter View Delegate
extension NewsListViewController : FilterViewDelegate {
    
    func filterByQuery(_ filterQuery: FilterQuery, andFilterString query: String) {
        
        Utilities.showProgressHUD()
        page = 1
        self.filterQuery = filterQuery
        self.query = query
        isFirstTimeLoad = true
        isInFilterMode = true
        filterButton.isEnabled = true
        filterResult.removeAll()
        newsListTableView.reloadData()
        
        if filterQuery == .none {
            return
        }
        
        newsListViewModel.getFilteredHeadlinesByPage(page, andFilterQuery: self.filterQuery, andQuery: self.query)
    }
    
    func closeViewWithFilter(_ filterOn: Bool) {
        
        filterButton.isEnabled = true
        
        if !filterOn {
            page = 2
            filterQuery = .none
            isInFilterMode = false
        }
    
        newsListTableView.reloadData()
    }
    
    func filterClosed() {
        filterButton.isEnabled = true
    }
}
