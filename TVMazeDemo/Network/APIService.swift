//
//  APIService.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import Foundation
import Alamofire
import SwiftyJSON

public final class NAPIService<T: Router> {
    typealias CompletionHandler = (_ response: JSON?, _ error: APIError?) -> Void
    private let manager: Session
    
    init(with manager: Session) { self.manager = manager }
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIMEOUT_INTERVAL_FOR_REQUEST
        configuration.timeoutIntervalForResource = TIMEOUT_INTERVAL_FOR_RESOURCES
        let manager = Session(configuration: configuration)
        self.init(with: manager)
    }
    
    func request(_ route: T, completion: @escaping CompletionHandler) -> DataRequest? {
        
        // Determine which error needs to display.
        if #available(iOS 12.0, *) {
            if Reachability.isConnectedToNetwork() && !NetworkChecker.shared.hasData {
                // Has internet but cannot access to data.
                DispatchQueue.main.async { completion(nil, APIError.noDataPermission) }
                return nil
            } else if !NetworkChecker.shared.hasData {
                // Has no internet.
                DispatchQueue.main.async { completion(nil, APIError.noInternetConnection) }
                return nil
            }
        } else {
            //  Just rely on Reachability
            guard Reachability.isConnectedToNetwork() else {
                DispatchQueue.main.async { completion(nil, APIError.noInternetConnection) } ; return nil
            }
        }
        
        let request = manager.request(route).validate().responseJSON(queue: DispatchQueue.networking) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async { completion(JSON(response.value!), nil) }
                break
            case .failure:
                print("Error: \(response.error.debugDescription)")
                break
            }
        }
        
        return request
    }
}
