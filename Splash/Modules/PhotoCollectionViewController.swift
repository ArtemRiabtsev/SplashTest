//
//  PhotoCollectionViewController.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: PhotoCollectionPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib(nibName: String(describing: CollectionViewCell.self), bundle: Bundle.main)
        collectionView.register(cell, forCellWithReuseIdentifier: CollectionViewCell.cellId)
    }
}

extension PhotoCollectionViewController: BaseView {
    
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as? CollectionViewCell else {
            return CollectionViewCell()
        }
        presenter?.configur(cell, with: indexPath.item)
        return cell
    }
}
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.frame.height - 8 * 11) / 10
        let width: CGFloat = (collectionView.frame.width - 9 * 4) / 3
        let size = CGSize(width: width, height: height)
        return size
    }
}
extension PhotoCollectionViewController: UICollectionViewDelegate {
    
}
