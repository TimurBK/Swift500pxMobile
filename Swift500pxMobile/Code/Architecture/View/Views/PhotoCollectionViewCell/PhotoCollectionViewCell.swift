//
//  PhotoCollectionViewCell.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

	@IBOutlet var photoImage: UIImageView!
	@IBOutlet var photographerName: UILabel!
	@IBOutlet var photoDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configure(viewModel: PhotoCellViewModel) {
		let url = URL(string: viewModel.imageAddress)!
		self.photoImage.kf.setImage(with:url)
		self.photographerName.text = viewModel.photographerName
		self.photoDescription.text = viewModel.photoDescription
	}

}
