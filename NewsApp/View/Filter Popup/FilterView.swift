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
        initData()
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
        prepCountriesList()
        
        countriesDropDownMenu = MKDropdownMenu(frame: CGRect(x: 0, y: 0, width: countriesDropDownListView.frame.size.width, height: countriesDropDownListView.frame.size.height))
        
        countriesDropDownListView.addSubview(countriesDropDownMenu)
        
        countriesDropDownMenu.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        countriesDropDownMenu.delegate = self
        countriesDropDownMenu.dataSource = self
    }
    
    func initSourcesDropDownMenu() {
        //prepSourcesList()
    }
    
    func prepCountriesList() {
        var countriesList = [String]()
        countriesList.append("Select Country")
        
        if let list = countries {
            countriesList.append(contentsOf: list)
        }
        
        countries = countriesList
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
        }
        
        return 0
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, viewForComponent component: Int) -> UIView {
        let cell = FilterListCell(frame: CGRect(x: 0, y: 0, width: dropdownMenu.frame.size.width, height: dropdownMenu.frame.size.height))
        let name = (dropdownMenu == countriesDropDownMenu) ? countries![component] : ""//sources![component]
        cell.setCountryName(name)
        
        return cell
    }
}
