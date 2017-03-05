//
//  CategoriesViewController.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import UIKit

// Table view data source and delegate should be moved to other objects
class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet var tableView: UITableView!
	var viewModel: CategoriesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Categories"
		self.configureTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Table View

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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.performSegue(withIdentifier: Constants.Navigation.categorySelectedSegue, sender: Constants.API.categories[indexPath.row])
	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as! CategoryViewController
		let viewModel = CategoryViewModel(category:(sender as! String))
		destination.viewModel = viewModel
    }

	// MARK: - Private

	private func configureTableView() {
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ReuseIdentifiers.categoryCellReuseID)
		self.tableView.tableFooterView = UIView()
	}
}
