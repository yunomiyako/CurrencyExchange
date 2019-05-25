//
//  ListExchangeRate.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class ListExchangeRate: UIView {
    // MARK: - Properties -
    lazy private var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    lazy private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var currencyChangeViewModels : [CurrencyChangeViewModel] = []
    private var contentHeight : CGFloat = 7000
    
    // MARK: - Life cycle events -
    internal required override init(frame: CGRect) {
        super.init(frame: frame)
        self.childInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.childInit()
    }
    
    private func childInit() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(collectionView)
        self.collectionView.register(CellExchangeRate.self, forCellWithReuseIdentifier: CellExchangeRate.identifier)
    }

    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutScrollView()
        self.layoutCollectionView()
    }
    
    private func layoutScrollView() {
        scrollView.contentSize = CGSize(width: self.frame.width, height: contentHeight)
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    private func layoutCollectionView() {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: contentHeight)
    }
    
    // MARK: - public functions -
    func loadData(currencyChangeViewModels : [CurrencyChangeViewModel]) {
        self.currencyChangeViewModels = currencyChangeViewModels
        self.collectionView.reloadData()
        self.contentHeight = self.collectionView.contentSize.height
    }
    
    
}

extension ListExchangeRate: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.currencyChangeViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellExchangeRate.identifier, for: indexPath) as? CellExchangeRate
        guard let cell = _cell else {return UICollectionViewCell()}
        let viewModel = self.currencyChangeViewModels[indexPath.item]
        cell.loadViewModel(viewModel : viewModel)
        return cell
    }
}

extension ListExchangeRate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ListExchangeRate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
