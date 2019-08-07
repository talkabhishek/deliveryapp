//
//  DeliveryListViewController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {
    struct Constant {
        static let title: String = NSLocalizedString("Things to Deliver", comment: "")
        static let separatorColor: UIColor = ColorConstant.appTheme
        static let zero: CGFloat = 0
        static let activityDimention: CGFloat = 50
        static let noDataLabelWidth: CGFloat = 300
        static let noDataLabelHeight: CGFloat = 500
        static let noDataLabelText: String = NSLocalizedString(#"""
                                No Data Found.
                                Pull down to refresh.
                                """#, comment: "")
        static let noDataLabelFont: UIFont = FontConstant.systemBold
        static let noDataLabelColor: UIColor = .lightGray
    }
    // MARK: - Instance variables
    var refreshControl = UIRefreshControl()
    var deliveryListViewModel: DeliveryListViewModel!
    var observers = [NSKeyValueObservation]()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = Constant.separatorColor
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: Constant.zero,
                                         y: Constant.zero,
                                         width: Constant.activityDimention,
                                         height: Constant.activityDimention)
        return activityIndicator
    }()

    let noDataFoundLabel: UILabel = {
        let infoLabel = UILabel(frame: CGRect(x: Constant.zero,
                                              y: Constant.zero,
                                              width: Constant.noDataLabelWidth,
                                              height: Constant.noDataLabelHeight))
        infoLabel.text = Constant.noDataLabelText
        infoLabel.font = Constant.noDataLabelFont
        infoLabel.textColor = Constant.noDataLabelColor
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        return infoLabel
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = Constant.title
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
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = true

        // Add no data view
        view.addSubview(noDataFoundLabel)
        noDataFoundLabel.anchor(widthConstant: Constant.noDataLabelWidth,
                                heightConstant: Constant.noDataLabelHeight)
        noDataFoundLabel.anchorCenterSuperview()
        noDataFoundLabel.isHidden = true

        // Add referesh control
        refreshControl.addTarget(self, action: #selector(refreshBody), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func setupObservers() {
        self.observers = [
            deliveryListViewModel.observe(\DeliveryListViewModel.deliveryViewModels,
                                          options: [.new]) { [weak self] (_, _) in
                                            self?.updateUIOnSuccess()
            }, deliveryListViewModel.observe(\DeliveryListViewModel.errorOccured,
                                             options: [.new]) { [weak self] (_, changedValue) in
                                                self?.updateUIOnError(changedValue.newValue as? Error)
            }, deliveryListViewModel.observe(\DeliveryListViewModel.isLoadingData,
                                             options: [.new], changeHandler: { [weak self] (_, changedValue) in
                                                self?.showLoadingActivity(changedValue.newValue ?? false)
            })
        ]
    }

    // MARK: Helper function
    // Pull to refresh action
    @objc func refreshBody(sender: Any) {
        deliveryListViewModel.getDeliveries(refresh: true)
    }

    // Update view data
    func showLoadingActivity(_ value: Bool) {
        tableView.tableFooterView?.isHidden = !value
        if !value { refreshControl.endRefreshing() }
    }

    func updateUIOnSuccess() {
        showHideNoData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    func updateUIOnError(_ error: Error?) {
        showHideNoData()
        showBannerWith(subtitle: error?.localizedDescription)
    }

    func showHideNoData() {
        noDataFoundLabel.isHidden = deliveryListViewModel.deliveryViewModels.count > 0
    }

    func pushDetailViewController(indexPath: IndexPath) {
        let item = deliveryListViewModel.deliveryViewModels[indexPath.row]
        let deliveryDetail = DeliveryDetailViewController()
        deliveryDetail.deliveryItemViewModel = item
        self.navigationController?.show(deliveryDetail, sender: true)
    }

    deinit {
        _ = observers.map({$0.invalidate()})
    }

}

extension DeliveryListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            //bottom reached
            deliveryListViewModel.getDeliveries()
        }
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
        return cell
    }
}

// Table view Delegate function
extension DeliveryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DeliveryTableViewCell {
            let item = deliveryListViewModel.deliveryViewModels[indexPath.row]
            cell.deliveryItem = item
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushDetailViewController(indexPath: indexPath)
    }
}
