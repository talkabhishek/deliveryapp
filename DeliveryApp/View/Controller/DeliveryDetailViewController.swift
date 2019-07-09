//
//  DeliveryDetailViewController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 07/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    // MARK: - Instance variables
    var deliveryItemViewModel: DeliveryItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = StaticString.delivertDetailView
        self.view.backgroundColor = UIColor.white

        setupViews()
    }

    private func setupViews() {
        let mapView = MKMapView()
        mapView.delegate = self
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: deliveryItemViewModel.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(deliveryItemViewModel)
        self.view.addSubview(mapView)

        let deliveryInfoView = DeliverItemTableViewCell()
        deliveryInfoView.configureWith(Item: deliveryItemViewModel)
        self.view.addSubview(deliveryInfoView)

        // Set Constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        deliveryInfoView.translatesAutoresizingMaskIntoConstraints = false
        deliveryInfoView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        deliveryInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        deliveryInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        deliveryInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        deliveryInfoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
extension DeliveryDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var view: MKAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "Pin")
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .system)
        }
        return view
    }
}
