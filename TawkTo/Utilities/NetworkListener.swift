//
//  NetworkListener.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 18/10/21.
//

import Foundation

protocol NetworkUpdates {
    func networkDidBecameActive()
    func networkDidBecameDeactive()
}

class NetworkListner : NSObject {
    
    static let shared = NetworkListner()
    
    var reachabilityStatus: Reachability.Connection = .unavailable
    let reachability = try! Reachability()
    var delegate: NetworkUpdates?
    
    var isNetworkAvailable : Bool {
        return reachability.connection != .unavailable
    }
    
    func startNWListner() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            self.delegate?.networkDidBecameActive()
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.delegate?.networkDidBecameDeactive()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
        }
    }
    
    
}
