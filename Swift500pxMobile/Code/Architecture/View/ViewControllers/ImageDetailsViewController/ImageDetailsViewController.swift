//
//  ImageDetailsViewController.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit
import Kingfisher

class ImageDetailsViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!

	@IBOutlet var photographerName: UILabel!
	@IBOutlet var photoDescription: UILabel!

	var viewModel: ImageDetailViewModel!

	deinit {
		self.imageView.kf.cancelDownloadTask()
	}

    override func viewDidLoad() {
		super.viewDidLoad()
		self.title = self.viewModel.photoDescription
		let url = URL(string: viewModel.imageAddress)!
		self.imageView.kf.indicatorType = .activity
		self.imageView.kf.setImage(with:url)
		self.photographerName.text = self.viewModel.photographerName
		self.photoDescription.text = self.viewModel.photoDescription
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
