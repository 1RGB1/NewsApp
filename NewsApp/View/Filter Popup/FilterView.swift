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
import FirebasePerformance

protocol FilterViewDelegate {
    func filterByQuery(_ filterQuery: FilterQuery, andFilterString query: String)
    func closeViewWithFilter(_ filterOn: Bool)
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
        let closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        blurView.addGestureRecognizer(closeTapGesture)
        
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
        
        let trace = Performance.startTrace(name: "CreateCountriesDropdownMenu")
        guard let countriesList = countries else {
            trace?.stop()
            return
        }

        let filterCountryTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openCountriesMenu))
        
        countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        countriesDropDownMenu.removeFromSuperview()
        countriesDropDownMenu = DropDown(frame: CGRect(x: 0, y: 0, width: countriesDropDownListView.frame.size.width, height: countriesDropDownListView.frame.size.height))
        countriesDropDownMenu.addGestureRecognizer(filterCountryTapGesture)
        countriesDropDownMenu.text = "Select Country"
        countriesDropDownMenu.delegate = self
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
        
        trace?.stop()
    }
    
    func initSourcesDropDownMenu() {
        
        let trace = Performance.startTrace(name: "CreateSourcesDropdownMenu")
        guard let sourcesList = sources else {
            trace?.stop()
            return
        }
        
        let filterSourceTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openSourcesMenu))
        
        sourceRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        sourcesDropDownMenu.removeFromSuperview()
        sourcesDropDownMenu = DropDown(frame: CGRect(x: 0, y: 0, width: sourcesDropDownListView.frame.size.width, height: sourcesDropDownListView.frame.size.height))
        sourcesDropDownMenu.addGestureRecognizer(filterSourceTapGesture)
        sourcesDropDownMenu.text = "Select Source"
        sourcesDropDownMenu.delegate = self
        sourcesDropDownMenu.listHeight = 200
        sourcesDropDownMenu.optionArray = getSourcesNames(sourcesList)
        sourcesDropDownMenu.didSelect { [weak self] (selectedSource, index, id) in
            self?.selectedSource = selectedSource
            self?.sourceRadioButton.setImage(UIImage(named: "RadioButtonChecked"), for: .normal)
            self?.countryRadioButton.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
            self?.countriesDropDownMenu.text = "Select Country"
        }
        
        sourcesDropDownListView.addSubview(sourcesDropDownMenu)
        
        sourcesDropDownMenu.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        trace?.stop()
    }
    
    @objc
    func openCountriesMenu() {
        countriesDropDownMenu.showList()
    }
    
    @objc
    func openSourcesMenu() {
        sourcesDropDownMenu.showList()
    }
    
    func getSourcesNames(_ sources: [SourceModel]) -> [String] {
        
        let trace = Performance.startTrace(name: "SourcesNames")
        
        var result = [String]()
        
        for source in sources {
            if let name = source.name {
                result.append(name)
            }
        }
        
        trace?.stop()
        
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
        closeViewWithFilter(false)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        if selectedCountry != "" {
            delegate?.filterByQuery(.country, andFilterString: selectedCountry)
            closeViewWithFilter(true)
            return
        }
        
        if selectedSource != "" {
            delegate?.filterByQuery(.source, andFilterString: selectedSource)
            closeViewWithFilter(true)
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
        
        delegate?.closeViewWithFilter(false)
    }
    
    // MARK: - Functions
    @objc
    func closeView() {
        closeViewWithFilter(false)
    }
    
    func closeViewWithFilter(_ filterOn: Bool) {
        blurView.removeBlurEffect()
        delegate?.closeViewWithFilter(filterOn)
        removeFromSuperview()
    }
}

// UITextField
extension FilterView : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
