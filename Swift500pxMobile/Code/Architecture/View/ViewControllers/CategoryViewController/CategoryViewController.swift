//
//  CategoryViewController.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class CategoryViewController: UIViewController {
	var viewModel: CategoryViewModel!
	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.configureCollectionView()
		self.title = self.viewModel.category
		self.indicator.startAnimating()
		self.viewModel.loadPhotos(page: 1) { [weak self] (photos, error) in
			self?.indicator.stopAnimating()
			self?.loadingDone(photos: photos, error: error)
		}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Constants.Navigation.fullscreenPhotoSegue {
			let destination = segue.destination as! ImageDetailsViewController
			let selectedViewModel = sender as! PhotoCellViewModel
			let viewModel = self.viewModel.imageDetailViewModel(for: selectedViewModel)
			destination.viewModel = viewModel
		}
    }

	// MARK: - Private

	private func configureCollectionView() {
		self.collectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifiers.photoCellReuseID)
	}

	fileprivate func loadingDone(photos:[Any], error: String?) {
		if (error == nil) {
			self.collectionView.reloadData()
		} else {
			let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(action)
			self.present(alert, animated: true, completion: nil)
		}
	}
}

extension CategoryViewController : UICollectionViewDataSource, UICollectionViewDelegate {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.photos.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.photoCellReuseID, for: indexPath) as! PhotoCollectionViewCell

		cell.configure(viewModel: self.viewModel.viewModelFor(index: indexPath.row))

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		self.performSegue(withIdentifier: Constants.Navigation.fullscreenPhotoSegue, sender: self.viewModel.viewModelFor(index: indexPath.row))
	}
}

extension CategoryViewController {
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		if scrollView == self.collectionView {
			let space = min(max(Constants.screensBeforeLoadingMore, (velocity.y - self.collectionView.frame.size.height / 1000 )), Constants.maxScreensBeforeLoadingMore)
			let shouldLoadPage = targetContentOffset.pointee.y > scrollView.contentSize.height - space * scrollView.frame.size.height
			if shouldLoadPage {
				self.viewModel.loadNextPage(completion: {[weak self] (photos, error) in
					self?.loadingDone(photos: photos, error: error)
				})
			}
		}
	}
}
