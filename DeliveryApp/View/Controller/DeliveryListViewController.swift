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
    var deliveryListViewModel: DeliveryListViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = StaticString.deliveryListView
        setupViews()
        deliveryListViewModel = DeliveryListViewModel()
        deliveryListViewModel.bindListItems { (error) in
            self.handleResponse(error: error)
        }
    }

    // MARK: Setup view programatically
    func setupViews() {
        // Add table view
        tableView = UITableView()
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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
        deliveryListViewModel.refreshList { (error) in
            self.handleResponse(error: error)
        }
    }

    func loadMoreItems(numOfRows: Int) {
        self.tableView.tableFooterView?.isHidden = false
        deliveryListViewModel.loadMore(With: numOfRows/DeliveriesRequest.limit) { (error) in
            self.refreshControl.endRefreshing()
            self.tableView.tableFooterView?.isHidden = true
            if let error = error {
                self.showAlert(message: error.message)
            } else {
                print("-------------------------:")
                print(numOfRows, self.deliveryListViewModel.deliveryViewModels.count)
                self.updateDataSource()
//                var indexPaths: [IndexPath] = []
//                for row in numOfRows..<self.deliveryListViewModel.deliveryViewModels.count {
//                    indexPaths.append(IndexPath(row: row, section: 0))
//                }
//                self.tableView.beginUpdates()
//                self.tableView.insertRows(at: indexPaths, with: .automatic)
//                self.tableView.endUpdates()
            }
        }
    }

    func handleResponse(error: ErrorResponse?) {
        if let error = error {
            self.showAlert(message: error.message, dismissAction: {
                self.refreshControl.endRefreshing()
                self.tableView.tableFooterView?.isHidden = true
            })
        } else {
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
        return deliveryListViewModel.deliveryViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            DeliveryTableViewCell.identifier, for: indexPath)
            as? DeliveryTableViewCell else {
                return UITableViewCell()
        }
        let item = deliveryListViewModel.deliveryViewModels[indexPath.row]
        cell.deliveryItem = item
        return cell
    }
}

// Table view Delegate function
extension DeliveryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let numOfRows = tableView.numberOfRows(inSection: lastSectionIndex)
        let lastRowIndex = numOfRows - 1
        if deliveryListViewModel.hasMoreData &&
            indexPath.section == lastSectionIndex &&
            indexPath.row == lastRowIndex &&
            numOfRows.isMultiple(of: DeliveriesRequest.limit) {
            loadMoreItems(numOfRows: numOfRows)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = deliveryListViewModel.deliveryViewModels[indexPath.row]
        let deliveryDetail = DeliveryDetailViewController()
        deliveryDetail.deliveryItemViewModel = item
        self.navigationController?.show(deliveryDetail, sender: true)
    }
}
