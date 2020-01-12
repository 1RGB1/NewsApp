//
//  FilterView.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/12/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit
import SnapKit
import MKDropdownMenu

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
    var countries: [String]?
    var sources: [SourceModel]?
    var countriesDropDownMenu = MKDropdownMenu()
    var sourcesDropDownMenu = MKDropdownMenu()
    var selectedCountry = ""
    var selectedSource = ""
    
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
        countriesDropDownMenu = MKDropdownMenu(frame: CGRect(x: 0, y: 0, width: countriesDropDownListView.frame.size.width, height: countriesDropDownListView.frame.size.height))
        
        countriesDropDownListView.addSubview(countriesDropDownMenu)
        
        countriesDropDownMenu.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        countriesDropDownMenu.delegate = self
        countriesDropDownMenu.dataSource = self
    }
    
    func initSourcesDropDownMenu() {
        sourcesDropDownMenu = MKDropdownMenu(frame: CGRect(x: 0, y: 0, width: sourcesDropDownListView.frame.size.width, height: sourcesDropDownListView.frame.size.height))
        
        sourcesDropDownListView.addSubview(sourcesDropDownMenu)
        
        sourcesDropDownMenu.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        sourcesDropDownMenu.delegate = self
        sourcesDropDownMenu.dataSource = self
    }
    
    // MARK: - Outlet Functions
    @IBAction func dismissButtonPressed(_ sender: Any) {
        closeView()
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Functions
    @objc
    func closeView() {
        countriesDropDownMenu.closeAllComponents(animated: true)
        sourcesDropDownMenu.closeAllComponents(animated: true)
        
        blurView.removeBlurEffect()
        removeFromSuperview()
    }
    
    func fillCountriesList() {
        
    }
    
    func fillSourcesList() {
        
    }
}

extension FilterView : MKDropdownMenuDataSource, MKDropdownMenuDelegate {
    func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return 1
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        if dropdownMenu == countriesDropDownMenu {
            return countries?.count ?? 0
        } else {
            return sources?.count ?? 0
        }
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, viewForComponent component: Int) -> UIView {
        let cell = FilterListCell(frame: CGRect(x: 0, y: 0, width: dropdownMenu.frame.size.width, height: dropdownMenu.frame.size.height))
        let name = (dropdownMenu == countriesDropDownMenu) ? "Select Country" : "Select Source"
        cell.setCountryName(name)
        
        return cell
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let cell = FilterListCell(frame: CGRect(x: 0, y: 0, width: dropdownMenu.frame.size.width, height: dropdownMenu.frame.size.height))
        var name = ""
        
        if dropdownMenu == countriesDropDownMenu {
            if let countriesList = countries {
                name = countriesList[row]
            }
        } else {
            if let sourcesList = sources {
                name = sourcesList[row].name ?? ""
            }
        }
        
        cell.setCountryName(name)
        return cell
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        dropdownMenu.closeAllComponents(animated: true)
        
        if dropdownMenu == countriesDropDownMenu {
            guard let countriesList = countries else { return }
            selectedCountry = countriesList[row]
        } else {
            guard let sourcesList = sources else { return }
            selectedSource = sourcesList[row].name ?? ""
        }
    }
}
