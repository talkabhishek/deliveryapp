//
//  DeliveryListViewController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import CoreData

class DeliveryListViewController: UIViewController {
    // MARK: - Instance variables
    var refreshControl = UIRefreshControl()
    var deliveryListViewModel: DeliveryListViewModel!
    var observers = [NSKeyValueObservation]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = ColorConstant.appTheme
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: ViewConstant.zero,
                                         y: ViewConstant.zero,
                                         width: ViewConstant.activityDimention,
                                         height: ViewConstant.activityDimention)
        return activityIndicator
    }()

    private let noDataFoundView: UIView = {
        let infoLabel = UILabel(frame: CGRect(x: ViewConstant.zero,
                                              y: ViewConstant.zero,
                                              width: ViewConstant.noDataLabelWidth,
                                              height: ViewConstant.noDataLabelHeight))
        infoLabel.text = StringConstant.noDataFoundText
        infoLabel.font = FontConstant.systemBold
        infoLabel.textColor = ColorConstant.noDataText
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        return infoLabel
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = StringConstant.deliveryListView
        setupViews()
        deliveryListViewModel = DeliveryListViewModel()
        setupObservers()
        deliveryListViewModel.getDeliveries()
    }

    // MARK: Setup view programatically
    func setupViews() {
        // Add table view
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = true

        // Add referesh control
        refreshControl.addTarget(self, action: #selector(refreshBody), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func setupObservers() {
        self.observers = [
            deliveryListViewModel.observe(\DeliveryListViewModel.deliveryViewModels,
                                          options: [.old, .new]) { [weak self] (_, _) in
                                            self?.updateDataSource()
            }, deliveryListViewModel.observe(\DeliveryListViewModel.error,
                                             options: [.old, .new]) { [weak self] (_, changedValue) in
                                                self?.updateUIOnError(error: changedValue.newValue as? Error)
            }
        ]
    }

    // MARK: Helper function
    // Pull to refresh action
    @objc func refreshBody(sender: Any) {
        // Code to refresh table view
        deliveryListViewModel.getDeliveries(refresh: true)
    }

    func handleResponse(error: ErrorResponse?) {
        if let error = error {
            self.showAlert(message: error.message, dismissAction: {
                self.refreshControl.endRefreshing()
                self.tableView.tableFooterView?.isHidden = true
                if self.deliveryListViewModel.deliveryViewModels.count == 0 {
                    self.tableView.tableHeaderView = self.noDataFoundView
                }
            })
        } else {
            self.refreshControl.endRefreshing()
            self.tableView.tableFooterView?.isHidden = true
            self.updateDataSource()
        }
    }

    // Update tableview data
    private func updateDataSource() {
        if deliveryListViewModel.deliveryViewModels.count == 0 {
            tableView.tableHeaderView = noDataFoundView
        } else {
            tableView.tableHeaderView = nil
        }
        tableView.tableFooterView?.isHidden = true
        refreshControl.endRefreshing()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    private func updateUIOnError(error: Error?) {
        tableView.tableFooterView?.isHidden = true
        refreshControl.endRefreshing()
        tableView.reloadData()
        if let error = error {
            showAlert(message: error.localizedDescription)
        }
    }

    deinit {
        _ = observers.map({$0.invalidate()})
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
        if indexPath.section == lastSectionIndex &&
            indexPath.row == lastRowIndex {
            tableView.tableFooterView?.isHidden = false
            deliveryListViewModel.getDeliveries(offset: numOfRows)
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
