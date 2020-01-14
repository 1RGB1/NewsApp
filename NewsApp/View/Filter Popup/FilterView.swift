//
//  FilterView.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/12/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit
import SnapKit
import iOSDropDown

protocol FilterViewDelegate {
    func filterByQuery(_ filterQuery: FilterQuery, andFilterString query: String)
    func cancleFilter()
}

class FilterView: UIView {

    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var countryRadioButton: UIButton!
    @IBOutlet weak var countriesDropDownListView: UIView!
    @IBOutlet weak var sourceRadioButton: UIButton!
    @IBOutlet weak var sourcesDropDownListView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: - Properties
    var newsListViewModel: NewsListViewModel?
    var delegate: FilterViewDelegate?
    var countries: [String]?
    var sources: [SourceModel]?
    var selectedCountry = ""
    var selectedSource = ""
    var countriesDropDownMenu = DropDown()
    var sourcesDropDownMenu = DropDown()
    
    // MARK: - Initializers sFunctions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        blurView.addGestureRecognizer(tap)
        
        initUI()
    }
    
    func initUI() {
        blurView.addBlurEffect()
        
        contentView.setCornerByValue(cornerRadius: true, value: 40)
        contentView.addShadow(color: UIColor.black, opacity: 0.3, radius: 2)
        
        countriesDropDownListView.addBorder(color: UIColor.black, width: 2)
        sourcesDropDownListView.addBorder(color: UIColor.black, width: 2)
        cancelButton.addBorder(color: UIColor.black, width: 2)
        filterButton.addBorder(color: UIColor.black, width: 2)
    }
    
    func initData() {
        initCountriesDropDownMenu()
        initSourcesDropDownMenu()
    }
    
    func initCountriesDropDownMenu() {
        
        guard let countriesList = countries else { return }

        countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        countriesDropDownMenu.removeFromSuperview()
        countriesDropDownMenu = DropDown(frame: CGRect(x: 0, y: 0, width: countriesDropDownListView.frame.size.width, height: countriesDropDownListView.frame.size.height))
        countriesDropDownMenu.isEnabled = true
        countriesDropDownMenu.text = "Select Country"
        countriesDropDownMenu.listHeight = 200
        countriesDropDownMenu.optionArray = countriesList
        countriesDropDownMenu.didSelect { [weak self] (selectedCountry, index, id) in
            self?.selectedCountry = selectedCountry
            self?.countryRadioButton.setImage(UIImage(named: "RadioButtonChecked"), for: .normal)
            self?.sourceRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
            self?.sourcesDropDownMenu.text = "Select Source"
        }
        
        countriesDropDownListView.addSubview(countriesDropDownMenu)
        
        countriesDropDownMenu.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)

        }
    }
    
    func initSourcesDropDownMenu() {
        
        guard let sourcesList = sources else { return }
        
        sourceRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        sourcesDropDownMenu.removeFromSuperview()
        sourcesDropDownMenu = DropDown(frame: CGRect(x: 0, y: 0, width: countriesDropDownListView.frame.size.width, height: countriesDropDownListView.frame.size.height))
        sourcesDropDownMenu.isEnabled = false
        sourcesDropDownMenu.text = "Select Source"
        sourcesDropDownMenu.listHeight = 200
        sourcesDropDownMenu.optionArray = getSourcesNames(sourcesList)
        sourcesDropDownMenu.didSelect { [weak self] (selectedSource, index, id) in
            self?.selectedSource = selectedSource
            self?.sourceRadioButton.setImage(UIImage(named: "RadioButtonChecked"), for: .normal)
            self?.countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
            self?.countriesDropDownMenu.text = "Select County"
        }
        
        sourcesDropDownListView.addSubview(sourcesDropDownMenu)
        
        sourcesDropDownMenu.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)

        }
    }
    
    func getSourcesNames(_ sources: [SourceModel]) -> [String] {
        var result = [String]()
        
        for source in sources {
            if let name = source.name {
                result.append(name)
            }
        }
        
        return result
    }
    
    // MARK: - Outlet Functions
    @IBAction func radioButtonPressed(_ sender: UIButton) {
        if sender == countryRadioButton {
            countryRadioButton.setImage(UIImage(named: "RadioButtonChecked"), for: .normal)
            sourceRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
            selectedSource = ""
            sourcesDropDownMenu.text = "Select Source"
        } else {
            countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
            sourceRadioButton.setImage(UIImage(named: "RadioButtonChecked"), for: .normal)
            selectedCountry = ""
            countriesDropDownMenu.text = "Select Country"
        }
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        closeView()
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        if selectedCountry != "" {
            delegate?.filterByQuery(.country, andFilterString: selectedCountry)
            closeView()
            return
        }
        
        if selectedSource != "" {
            delegate?.filterByQuery(.source, andFilterString: selectedSource)
            closeView()
            return
        }
    }
    
    @IBAction func cancleFilterButtonPressed(_ sender: Any) {
        countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        selectedCountry = ""
        countriesDropDownMenu.text = "Select Country"
        
        sourceRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        selectedSource = ""
        sourcesDropDownMenu.text = "Select Source"
        
        delegate?.cancleFilter()
    }
    
    // MARK: - Functions
    @objc
    func closeView() {
        blurView.removeBlurEffect()
        removeFromSuperview()
    }
}
