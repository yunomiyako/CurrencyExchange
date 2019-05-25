//
//  ViewController.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/23.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    // MARK - view layer -
    lazy fileprivate var template : CurrencyConversionTemplate = {
        let template = CurrencyConversionTemplate()
        template.delegate = self
        return template
    }()
    
    //MARK - properties -
    private var presenter : CurrencyConversionPresenter?
    
    //MARK - lifecycles -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(template)
        self.presenter = CurrencyConversionPresenter(viewController: self)
        self.presenter?.loadSupportedCurrencies()
    }
    
    override func viewDidLayoutSubviews() {
        self.layoutTemplate()
    }
    
    private func layoutTemplate() {
        template.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
}

extension CurrencyConversionViewController : CurrencyConversionPresenterInput {
    func endLoadingSupportedCurrencies(viewModels: [SupportedCurrencyViewModel]) {
        template.setSupportedCurrencies(viewModels : viewModels)
    }
    
    func endLoadingCurrencyChangeViewModel(viewModels: [CurrencyChangeViewModel]) {
        template.setCurrencyChangeRates(viewModels : viewModels)
    }
}

extension CurrencyConversionViewController : CurrencyConversionTemplateDelegate {
    func selectedCurrency(viewModel: SupportedCurrencyViewModel) {
        self.presenter?.selectedCertainCurrency(currency: viewModel)
    }
}
