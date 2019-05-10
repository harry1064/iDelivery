//
//  DeliveryModel.swift
//  iDelivery
//
//  Created by Harpreet Singh on 10/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit
import Foundation

class DeliveryModel: Codable
{
    let id: Int64
    let description: String
    let imageUrl: String
    let location: DeliveryLocation
}

struct DeliveryLocation: Codable {
    let lat: Double
    let lng: Double
    let address: String
}
