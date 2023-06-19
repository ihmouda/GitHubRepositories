//
//  NetworkingManager+Reachability.swift
//  GitHubRepositories
//
//  Created by mihmouda on 17/06/2023.
//

import Alamofire

/**
 Notification names related to network reachability status changes.
 
 The `NetworkingManagerNotifications` enum defines notification names that can be used to observe and handle network reachability status changes.
 
 - `connectedToInternet`: Notification name for when the device is connected to the internet.
 - `notConnectedToInternet`: Notification name for when the device is not connected to the internet.
 */
enum NetworkingManagerNotifications: String {
    
    case connectedToInternet = "ConnectedToInternetNotification"
    case notConnectedToInternet = "NotConnectedToInternetNotification"
}

extension NetworkingManager {
    
    /**
     Starts observing network reachability status changes.
     
     This method starts listening to network reachability status updates and posts corresponding notifications based on the status changes.
     - Important: Make sure to add observers to handle the notifications posted by this method.
     */
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            
            switch status {
            case .reachable(_):
                // The device is connected to the internet
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NetworkingManagerNotifications.connectedToInternet.rawValue), object: nil)
                
            default:
                // The device is not connected to the internet
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NetworkingManagerNotifications.notConnectedToInternet.rawValue), object: nil)
            }
        })
    }
}
