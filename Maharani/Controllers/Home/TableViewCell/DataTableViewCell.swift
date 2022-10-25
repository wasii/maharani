//
//  DataTableViewCell.swift
//  Derive
//
//  Created by Mac User on 26/05/21.
//  Copyright © 2021 Mac User. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    var baseVc :UIViewController?
    @IBOutlet weak var collectionView: IntrinsicCollectionView!
    var serviceCategories: [Category]?
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    //MARK: - Populate Data
    func populateServiceDetailsWith(categories : [Category]?) {
        serviceCategories = categories
        collectionView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: Bundle(for: ItemCollectionViewCell.self)), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
}
extension DataTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  serviceCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        let item = serviceCategories?[indexPath.row]
        cell.populateServiceCategories(categories:item )
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    
}
extension DataTableViewCell:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 26)/2, height:180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = serviceCategories?[indexPath.row]
        Switcher.goToCategorisPrice(delegate: baseVc, category:item)
    }
    
}
