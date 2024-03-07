//
//  ReachabilityHelper.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
import SystemConfiguration

/// ReachabilityHelper
final class ReachabilityHelper {
    
    /// Determining whether the device is connected to the internet or not
    /// - Returns: true or false
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }
}
