//
//  Reachability.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import Foundation
import SystemConfiguration
import Network

public class Reachability {
  class func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }) else {
      return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return false
    }
    
    var isReachable = false
    
    if flags.contains(.reachable) {
      isReachable = true
    } else if flags.contains(.isWWAN) {
      isReachable = true
    }
    
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
  }
}

// MARK: - NetworkChecker

/// Checks the network using the Network.framework. Only available after iOS 12.
@available(iOS 12.0, *)
class NetworkChecker {
    private let monitor = NWPathMonitor()
    private(set) var hasData = true // It's safer to assume the user has data.
    private(set) var hasCellularData = false

    static let shared = NetworkChecker()
    
    /// Starts checking network changes.
    /// This function dispatch a "Monitor" queue.
    func startChecker() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.hasData = true
                self.hasCellularData = path.isExpensive
            } else {
                self.hasData = false
                self.hasCellularData = false
            }
        }
        let queue = DispatchQueue(label: "Monitor", attributes: .concurrent)
        monitor.start(queue: queue)
    }
}
