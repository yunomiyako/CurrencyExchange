//
//  ViewController.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/23.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    //view layer
    lazy private var template : CurrencyConversionTemplate = {
        let template = CurrencyConversionTemplate()
        return template
    }()
    
    //properties
    private var presenter : CurrencyConversionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(template)
        
        self.presenter = CurrencyConversionPresenter(viewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        self.layoutTemplate()
    }
    
    private func layoutTemplate() {
        template.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
}

extension CurrencyConversionViewController : CurrencyConversionPresenterInput {
    func endLoadingCurrencyChangeViewModel(viewModels: [CurrencyChangeViewModel]) {
        //hogehoge
    }
    
    func endLoadSupportedCurrencies() {
        //hogehoge
    }
}
