//
//  DeliveryListViewController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import CoreData

class DeliveryListViewController: UIViewController {
    // MARK: - Instance variables
    private var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var deliveryItemListViewModel: DeliveryItemListViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = StaticString.deliveryListView

        setupViews()

        deliveryItemListViewModel = DeliveryItemListViewModel()
        deliveryItemListViewModel.bindListItems {
            self.tableView.tableFooterView?.isHidden = true
            self.updateDataSource()
        }
    }

    // MARK: Setup view programatically
    func setupViews() {
        // Add table view
        tableView = UITableView()
        tableView.register(DeliverItemTableViewCell.self, forCellReuseIdentifier: DeliverItemTableViewCell.identifier)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Add table view footer
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        self.tableView.tableFooterView = activityIndicator
        self.tableView.tableFooterView?.isHidden = false

        // Add referesh control
        refreshControl.addTarget(self, action: #selector(refreshBody), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    // MARK: Helper function
    // Pull to refresh action
    @objc func refreshBody(sender: Any) {
        // Code to refresh table view
        self.updateDataSource()
        deliveryItemListViewModel.refreshList {
            self.refreshControl.endRefreshing()
            self.tableView.tableFooterView?.isHidden = true
            self.updateDataSource()
        }
    }

    // Update tableview data
    private func updateDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

}

// Table view DataSource function
extension DeliveryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryItemListViewModel.deliveryItemViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            DeliverItemTableViewCell.identifier, for: indexPath)
            as? DeliverItemTableViewCell else {
                return UITableViewCell()
        }
        let item = deliveryItemListViewModel.deliveryItemViewModels[indexPath.row]
        cell.configureWith(Item: item)
        return cell
    }
}

// Table view Delegate function
extension DeliveryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let numOfRows = tableView.numberOfRows(inSection: lastSectionIndex)
        let lastRowIndex = numOfRows - 1
        if deliveryItemListViewModel.hasMoreData &&
            indexPath.section == lastSectionIndex &&
            indexPath.row == lastRowIndex &&
            numOfRows.isMultiple(of: 10) {
            self.tableView.tableFooterView?.isHidden = false
            deliveryItemListViewModel.loadMore(With: numOfRows/10) {
                self.tableView.tableFooterView?.isHidden = true
                self.updateDataSource()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = deliveryItemListViewModel.deliveryItemViewModels[indexPath.row]
        let deliveryDetail = DeliveryDetailViewController()
        deliveryDetail.deliveryItemViewModel = item
        self.navigationController?.show(deliveryDetail, sender: true)
    }
}
