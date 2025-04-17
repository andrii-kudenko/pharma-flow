//
//  Colors.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//

import SwiftUICore

extension String {
    func statusColor() -> Color {
        switch self.lowercased() {
        case "pending":
            return .orange
        case "processing":
            return .blue
        case "shipped":
            return .green
        case "cancelled":
            return .red
        case "completed":
            return .gray
        case "delivered":
            return .blue
        case "confirmed":
            return .mint
        default:
            return .secondary
        }
    }
}
