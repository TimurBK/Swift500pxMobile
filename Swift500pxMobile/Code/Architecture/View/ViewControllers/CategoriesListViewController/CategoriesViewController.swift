//
//  CategoriesViewController.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit

import ReactiveSwift
import ReactiveCocoa

// Table view data source and delegate should be moved to other objects
class CategoriesViewController: UIViewController {
	@IBOutlet var tableView: UITableView!
	var viewModel: CategoriesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = self.viewModel.title
		self.configureTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Constants.Navigation.categorySelectedSegue {
			let destination = segue.destination as! CategoryViewController
			let category = sender as! String
			let viewModel = self.viewModel.categoryViewModel(for: category)
			destination.viewModel = viewModel
		}
    }

	// MARK: - Private

	private func configureTableView() {
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ReuseIdentifiers.categoryCellReuseID)
		self.tableView.tableFooterView = UIView()
	}
}

extension CategoriesViewController : UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.categoryCellReuseID, for: indexPath)
		let text = self.viewModel.objectForIndex(index: indexPath.row)
		cell.textLabel?.text = text
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.objectsCount()
	}
}

extension CategoriesViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.performSegue(withIdentifier: Constants.Navigation.categorySelectedSegue, sender: self.viewModel.objectForIndex(index: indexPath.row))
	}
}
