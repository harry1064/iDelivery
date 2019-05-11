//
//  DeliveryDetailViewController.swift
//  iDelivery
//
//  Created by Harpreet Singh on 11/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {

    var deliveryModel: DeliveryModel? {
        didSet {
            mapView.removeAnnotation(annotation)
            if let deliveryModel = self.deliveryModel {
                deliveryDetailLabel.text = "\(deliveryModel.description)\n\nAddress: \(deliveryModel.location.address)"
                let centerCoordinate = CLLocationCoordinate2D(latitude: deliveryModel.location.lat, longitude:deliveryModel.location.lng)
                annotation.coordinate = centerCoordinate
                annotation.title = "\(deliveryModel.location.address)"
                annotation.subtitle = "\(deliveryModel.description)"
                mapView.addAnnotation(annotation)
            }
        }
    }

    private var annotation = MKPointAnnotation()

    private let baseScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.setBaseViewConfiguration()
        return scrollView
    }()

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.setBaseViewConfiguration()
        return mapView
    }()

    private let deliveryDetailLabel: UILabel = {
        let label = UILabel()
        label.setBaseViewConfiguration()
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        title = "Delivery Detail"
        view.backgroundColor = .white
        view.addSubview(baseScrollView)
        baseScrollView.addSubview(mapView)
        baseScrollView.addSubview(deliveryDetailLabel)

        view.addConstraintWithFormat("H:|-0-[v0]-0-|", views: baseScrollView)
        view.addConstraintWithFormat("V:|-0-[v0]-0-|", views: baseScrollView)
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        deliveryDetailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        deliveryDetailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        baseScrollView.addConstraintWithFormat("V:|-10-[v0(==\(view.bounds.size.width))]-10-[v1]-10-|", views: mapView, deliveryDetailLabel)
    }

}
