//
//  DeliveryListTableViewCell.swift
//  iDelivery
//
//  Created by Harpreet Singh on 10/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit

class DeliveryListTableViewCell: UITableViewCell {

    static let identifier = "DeliveryListCell"

    private let deliveryImageViewHeight: Double = 80

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setBaseViewConfiguration()
        label.textColor = .darkGray
        return label;
    }()

    private let deliveryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setBaseViewConfiguration()
        imageView.contentMode = .scaleAspectFit
        return imageView;
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        deliveryImageView.image = UIImage(named: "delivery-van-default")
        deliveryImageView.layer.cornerRadius = CGFloat(deliveryImageViewHeight / 2.0)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        contentView.addSubview(deliveryImageView)
        contentView.addSubview(descriptionLabel)

        contentView.addConstraintWithFormat("H:|-10-[v0(==\(deliveryImageViewHeight))]-10-[v1]-0-|", views: deliveryImageView, descriptionLabel)
        contentView.addConstraintWithFormat("V:[v0(==\(deliveryImageViewHeight))]", views: deliveryImageView)
        deliveryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addConstraintWithFormat("V:|-10-[v0(>=\(deliveryImageViewHeight))]-10-|", views: descriptionLabel)
    }

    func configure(withModel model:DeliveryModel) {
        descriptionLabel.text = model.description
    }

}
