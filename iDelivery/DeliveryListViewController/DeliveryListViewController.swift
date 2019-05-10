//
//  ViewController.swift
//  iDelivery
//
//  Created by Harpreet Singh on 10/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {

    var deliveryListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.setBaseViewConfiguration()
        // This is to remove seperator lines for empty table view.
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    var noDeliveriesUIlabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "No Deliveries!"
        label.textColor = .lightGray;
        label.textAlignment = .center;
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Deiliveries"
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        noDeliveriesUIlabel.frame.size = view.bounds.size;
        view.addSubview(deliveryListTableView)

        // setup constraints for deliveryListTableView
        view.addConstraintWithFormat("H:|-[v0]-|", views: deliveryListTableView)
        view.addConstraintWithFormat("V:|-[v0]-|", views: deliveryListTableView)
    }

}

