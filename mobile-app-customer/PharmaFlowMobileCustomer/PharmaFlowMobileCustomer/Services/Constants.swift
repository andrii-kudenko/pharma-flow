//
//  Constants.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

enum Constants {
    //change based on testing mode   (on simulator / physical device)
    static let useSimulatorMode = false

    static var baseURL: String {
        if useSimulatorMode {
            return "http://localhost:5062/api"
        } else {
            //replace with your local ip if testing on physical device
            return "http://172.20.10.2:5062/api"
        }
    }
}
