//
//  ActivityAttributes.swift
//  DriveActivity
//
//  Created by Deeksha Sharma on 7/19/23.
//

import Foundation
import SwiftUI
import ActivityKit

struct BookCabAttributes: ActivityAttributes {
    public typealias cabArrivalStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var driverName: String
        var estimatedReachTime: ClosedRange<Date>
    }

    var vechileNumber: String
    var totalAmount: String
}
