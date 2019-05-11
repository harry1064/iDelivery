//
//  ViewController.swift
//  iDelivery
//
//  Created by Harpreet Singh on 10/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {

    private var deliveries:[DeliveryModel] = [] {
        didSet {
            let count = deliveries.count
            if count == 0 {
                noDeliveriesUIlabel.text = "No deliveries!"
            } else {
                noDeliveriesUIlabel.text = ""
            }
        }
    }

    private var currentOffset: Int = -20

    private var currentLimit: Int = 20

    private var isAllDeliveryFetched: Bool = false

    private var deliveryListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.setBaseViewConfiguration()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        // This is to remove seperator lines for empty table view.
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    private let noDeliveriesUIlabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray;
        label.text = "No deliveries!"
        label.textAlignment = .center;
        return label
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.setBaseViewConfiguration()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()

    var loaderBaseView: UIView!

    private var isFetchingDeliveries: Bool = false {
        didSet {
            if self.isFetchingDeliveries {
                deliveryListTableView.tableFooterView = loaderBaseView
                activityIndicatorView.startAnimating()
                activityIndicatorView.isHidden = false
            } else {
                deliveryListTableView.tableFooterView = UIView(frame: .zero)
                activityIndicatorView.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Deiliveries"
        view.backgroundColor = .white
        setupUI()
        fetchDeliveries()
    }

    private func setupUI() {
        loaderBaseView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40));
        loaderBaseView.addSubview(activityIndicatorView)
        deliveryListTableView.backgroundView = noDeliveriesUIlabel
        deliveryListTableView.delegate = self
        deliveryListTableView.dataSource = self
        deliveryListTableView.register(DeliveryListTableViewCell.self, forCellReuseIdentifier: DeliveryListTableViewCell.identifier)
        noDeliveriesUIlabel.frame.size = view.bounds.size;
        view.addSubview(deliveryListTableView)

        // setup constraints for deliveryListTableView
        view.addConstraintWithFormat("H:|-0-[v0]-0-|", views: deliveryListTableView)
        view.addConstraintWithFormat("V:|-0-[v0]-0-|", views: deliveryListTableView)

        activityIndicatorView.centerYAnchor.constraint(equalTo: loaderBaseView.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: loaderBaseView.centerXAnchor).isActive = true
    }

    func fetchDeliveries() {
        if self.isFetchingDeliveries || self.isAllDeliveryFetched {
            return
        }
        self.isFetchingDeliveries = true
        currentOffset += currentLimit
        NetworkManager.sharedManager.getDeliverlies(offset:currentOffset , limit: currentLimit) { [weak self] (deliveriesArray, error) in
            self?.isFetchingDeliveries = false
            if let error = error {
                print("[ERROR] \(error.localizedDescription)")
                self?.presentAlert(message: "Something went wrong 😞. Please try again later.")
                if let s = self {
                    s.currentOffset -= s.currentLimit
                }
                return
            }
            let newDeliveries = deliveriesArray ?? []
            self?.isAllDeliveryFetched = newDeliveries.count == 0
            self?.deliveries.append(contentsOf: newDeliveries)
            self?.deliveryListTableView.reloadData()
        }
    }

    func presentAlert(message : String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}


extension DeliveryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryListTableViewCell.identifier, for: indexPath) as! DeliveryListTableViewCell
        let model = deliveries[indexPath.row]
        cell.configure(withModel: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = deliveries[indexPath.row]
        let vc = DeliveryDetailViewController()
        vc.deliveryModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 50 is added so user have to scroll a little bit to initiate the next fetching batch
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height + 50 ) && !isFetchingDeliveries){
            fetchDeliveries()
        }
    }



}
