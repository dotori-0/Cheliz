//
//  NetworkMonitor.swift
//  Cheliz
//
//  Created by SC on 2023/03/21.
//

import Foundation
import Network

final class NetworkMonitor {
    private init() { }
    
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    
    func startMonitoring(noConnectionHandler: @escaping () -> Void) {
        monitor.start(queue: DispatchQueue.global())
        print("🛰 startMonitoring")
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
//                print("인터넷 연결 ⭕️")
            } else {
//                print("인터넷 연결 ❌")
                DispatchQueue.main.async {
                    noConnectionHandler()
                }
            }
        }
    }
    
    func stopMonitoring() {
        print("🛸 Stopped Monitoring")
        monitor.cancel()
    }
}
