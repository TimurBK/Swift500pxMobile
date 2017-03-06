//
//  CategoryViewController.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class CategoryViewController: UIViewController {
	var viewModel: CategoryViewModel!
	@IBOutlet var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = self.viewModel.category
		self.viewModel.loadPhotos(page: 0) { (photos, error) in
			print("Logging")
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

	// MARK: - Private

	private func configureCollectionView() {

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
	}
}
