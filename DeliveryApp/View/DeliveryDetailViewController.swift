//
//  DeliveryDetailViewController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    // MARK: - Instance variables
    var deliveryItemViewModel: DeliveryViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = StringConstant.delivertDetailView
        self.view.backgroundColor = UIColor.white

        setupViews()
    }

    // MARK: Setup view programatically
    private func setupViews() {
        let mapView = MKMapView()
        mapView.delegate = self
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: deliveryItemViewModel.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(deliveryItemViewModel)
        view.addSubview(mapView)
        mapView.fillSuperview()

        let deliveryInfoView = DeliveryItemView()
        deliveryInfoView.deliveryItem = deliveryItemViewModel
        view.addSubview(deliveryInfoView)
        deliveryInfoView.anchor(top: nil,
                                left: view.leftAnchor,
                                bottom: view.bottomAnchor,
                                right: view.rightAnchor,
                                topConstant: 0,
                                leftConstant: 15,
                                bottomConstant: 50,
                                rightConstant: 15,
                                widthConstant: 0,
                                heightConstant: 0)

        deliveryInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    }
}

// MapView Delegate
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
