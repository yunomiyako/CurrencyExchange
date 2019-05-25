//
//  ListCurrency.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit
import iOSDropDown
protocol ListCurrencyDelegate : class {
    func selectedCurrency(viewModel : SupportedCurrencyViewModel)
}


class ListCurrency: UIView {
    // MARK : - propaties -
    lazy private var dropDown : DropDown = {
        let view = DropDown(frame: CGRect.zero)
        return view
    }()
    lazy private var baseView : UIView = {
        let view = UIView()
        return view
    }()
    
    private var supportedCurrencies : [SupportedCurrencyViewModel] = []
    weak var delegate : ListCurrencyDelegate? = nil
    
    // MARK: - Life cycle events -
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(baseView)
        self.addSubview(dropDown)
        
        // baseView
        baseView.backgroundColor = UIColor.yellow
        
        // dropDown
        dropDown.didSelect() { (value , index , id) in
            let currency = self.supportedCurrencies[index]
            self.delegate?.selectedCurrency(viewModel: currency)
        }
    }
    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutBaseView()
        self.layoutDropDown()
    }
    
    private func layoutBaseView() {
        let margin : CGFloat = 20
        let width = self.frame.width - 2 * margin
        let height : CGFloat = 50
        baseView.frame = CGRect(x: margin , y: margin, width: width , height: height)
    }
    
    private func layoutDropDown() {
        let margin : CGFloat = 10
        let width = self.baseView.frame.width - 2 * margin
        let height : CGFloat = 30
        dropDown.frame = CGRect(x: self.baseView.frame.minX + margin , y: self.baseView.frame.minY + margin, width: width , height: height)
    }
    
    
    // MARK : - public functions -
    func loadData(viewModels : [SupportedCurrencyViewModel]) {
        self.supportedCurrencies = viewModels
        
        //FIXME : a little bit awkward
        self.dropDown.optionArray = []
        for vm in viewModels {
            self.dropDown.optionArray.append(vm.displayName())
        }
    }
}
