//
//  NetworkingController.swift
//  AvitoProjectTest
//
//  Created by Zakaria elmouatassim on 05/03/2018.
//  Copyright © 2018 Zakaria elmouatassim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkingController: UIViewController {

    // MARK: - Type alias
    typealias Parameters = [String: Any]

    // MARK: - Sending request
    func networkingGET(url: String, headers: [String : String])
    {
        networkingSendRequest(url: url, method: .get, headers: headers)
    }

    fileprivate func networkingSendRequest(url: String, method: HTTPMethod, headers: [String : String])
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: method, parameters: [:], encoding: URLEncoding.queryString, headers: headers).responseJSON {
                    response in
                    switch response.result
                    {
                    case .success (let value) :
                        // Result of response serialization
                        print("\n\n Networking Result = \(value)")
                        self.networkingGotResponse(json: JSON(value))
                        break
                        
                    case .failure (let error) :
                        let statusString = response.response?.statusCode != nil ? "\(response.response?.statusCode ?? -1)" : "Null"
                        self.networkingGotError(error: "\(error)", status: statusString)
                        break
                    }
            }
    }

    // MARK: - Getting response
    func networkingGotResponse (json: JSON)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("\n\n Networking JSON = \(json)")
    }

    // MARK: - Getting error
    func networkingGotError(error: String, status: String)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        print("\n\n Status code = \(status)"); print("\n\n Error = \(error)")
    }
    


}
