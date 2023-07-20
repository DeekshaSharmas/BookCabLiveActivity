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
    typealias ContentState = CabContentState
    
    var customerName: String
    var totalAmount: String
}

public struct CabContentState: Codable, Hashable {
    var driverName: String
    var vechileNumber: String
    var estimatedReachTime: ClosedRange<Date>
}
