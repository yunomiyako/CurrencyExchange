//
//  ViewController.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/23.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy private var template : CurrencyConversionTemplate = {
        let template = CurrencyConversionTemplate()
        return template
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(template)
    }
    
    override func viewDidLayoutSubviews() {
        self.layoutTemplate()
    }
    
    private func layoutTemplate() {
        template.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
}

