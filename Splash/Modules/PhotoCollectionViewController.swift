//
//  PhotoCollectionViewController.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var menuConstantHeight: NSLayoutConstraint!
    private var footerView: LoadFooterView?
    private var menuIsOpen = false
    private var isLoading = false
    var presenter: PhotoCollectionPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        let cell = UINib(nibName: String(describing: CollectionViewCell.self), bundle: Bundle.main)
        collectionView.register(cell, forCellWithReuseIdentifier: CollectionViewCell.cellId)
        let footerView = UINib(nibName: String(describing: LoadFooterView.self), bundle: Bundle.main)
        collectionView.register(footerView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadFooterView.viewIdentifier)
    }
    
    //MARK: - Private
    
    private func uiSetup() {
        navigationItem.title = "Photos"
        navigationItem.setHidesBackButton(true, animated: true)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(rightItemAction))
        navigationItem.setRightBarButton(rightItem, animated: true)
        searchBar.delegate = self
    }
    //MARK: - Actions
    
    @objc func rightItemAction(_ sender: Any) {
        menuIsOpen = !menuIsOpen
        menuConstantHeight.constant = menuIsOpen ? 56 : 0
        UIView.animate(withDuration: 0.33, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
    //MARK: UISearchBarDelegate

extension PhotoCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        presenter?.pageRefresh()
        presenter?.load()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 3 {
            presenter?.pageRefresh()
            presenter?.search(searchText)
        }
        if searchText.count > 3 {
            presenter?.search(searchText)
        }
    }
}

extension PhotoCollectionViewController: BaseView {
    func imagesDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.isLoading = false
        }
    }
}

    //MARK: UICollectionViewDataSource

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as? CollectionViewCell else {
            return CollectionViewCell()
        }
        presenter?.configur(cell, with: indexPath.item)
        return cell
    }
}

    //MARK: UICollectionViewDelegateFlowLayout

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.frame.height - 8 * 11) / 10
        let width: CGFloat = (collectionView.frame.width - 9 * 4) / 3
        let size = CGSize(width: width, height: height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return isLoading ? CGSize.zero : CGSize(width: collectionView.bounds.size.width, height: 55)
    }
}

    //MARK: UICollectionViewDelegate

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadFooterView.viewIdentifier, for: indexPath) as! LoadFooterView
            footerView = aFooterView
            footerView?.backgroundColor = UIColor.clear
            return aFooterView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadFooterView.viewIdentifier, for: indexPath)
            return headerView
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            footerView?.prepareInitialAnimation()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            footerView?.stopAnimate()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.itemPressed(indexPath.item)
    }
}

    //MARK: UIScrollViewDelegate

extension PhotoCollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 100.0
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let diffHeight = contentHeight - contentOffset
        let frameHeight = scrollView.bounds.size.height
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold)
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(abs(triggerThreshold),1.0)
        footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            footerView?.animateFinal()
        }
    }
    
    //compute the offset and call the load method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let diffHeight = contentHeight - contentOffset
        let frameHeight = scrollView.bounds.size.height
        let pullHeight  = abs(diffHeight - frameHeight)
        if pullHeight == 0.0 {
            if (footerView?.isAnimatingFinal)! {
                isLoading = true
                footerView?.startAnimate()
                if let query = searchBar.text, query.count >= 3 {
                    presenter?.search(query)
                    return
                }
                presenter?.load()
            }
        }
    }
}
