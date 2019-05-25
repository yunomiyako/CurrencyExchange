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
        dropDown.didSelect() { (value , index , id) in
            let currency = self.supportedCurrencies[index]
            self.delegate?.selectedCurrency(viewModel: currency)
        }
        self.addSubview(dropDown)
    }
    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutDropDown()
    }
    
    private func layoutDropDown() {
        let margin : CGFloat = 20
        let width = self.frame.width - 2 * margin
        let height : CGFloat = 30
        dropDown.frame = CGRect(x: margin , y: margin, width: width , height: height)
    }
    
    
    // MARK : - public functions -
    func loadData(viewModels : [SupportedCurrencyViewModel]) {
        self.supportedCurrencies = viewModels
        
        //FIXME : a little bit awkward
        self.dropDown.optionArray = []
        for vm in viewModels {
            self.dropDown.optionArray.append(vm.displayName())
        }
        print(self.dropDown.optionArray.count)
    }
}
