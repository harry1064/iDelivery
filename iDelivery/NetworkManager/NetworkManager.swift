//
//  NetworkManager.swift
//  iDelivery
//
//  Created by Harpreet Singh on 11/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {

    private let baseUrl = "https://mock-api-mobile.dev.lalamove.com"

    static let sharedManager = NetworkManager()

    func getDeliverlies(offset: Int, limit: Int, completionHandler: @escaping (_ deliveries: [DeliveryModel]?, _ error: Error?) -> Void) {
        Alamofire.request("\(baseUrl)/deliveries?offset=\(offset)&limit=\(limit)").responseData{
            responseData in
            if let error = responseData.error {
                completionHandler(nil, error)
            } else if let data = responseData.data , let deliveries = try? JSONDecoder().decode([DeliveryModel].self, from: data) {
                completionHandler(deliveries, nil)
            } else {
                // Sometime server throw error as "Internal Server Error"
                completionHandler(nil, NSError(domain: "Internal Server Error", code: 1, userInfo: nil))
            }
        }
    }

}
