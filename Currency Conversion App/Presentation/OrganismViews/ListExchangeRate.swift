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
        return collectionView
    }()
    private var currencyChangeViewModels : [CurrencyChangeViewModel] = []
    
    
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
        self.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    
        self.collectionView.register(CellExchangeRate.self, forCellWithReuseIdentifier: CellExchangeRate.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutCollectionView()
    }
    
    private func layoutCollectionView() {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    // MARK: - public functions -
    func loadData(currencyChangeViewModels : [CurrencyChangeViewModel]) {
        self.currencyChangeViewModels = currencyChangeViewModels
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
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
