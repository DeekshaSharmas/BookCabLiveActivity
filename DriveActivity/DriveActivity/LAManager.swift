//
//  LAManager.swift
//  DriveActivity
//
//  Created by Deeksha Sharma on 7/19/23.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    
    func startBookingCab() {
        let orderCabAttributes = BookCabAttributes(vechileNumber: "UP2345", totalAmount: "Rs. 450")

        //let initialContentState = ActivityContent
        let initialContentState = BookCabAttributes.cabArrivalStatus(driverName: "Anmol", estimatedReachTime: Date()...Date().addingTimeInterval(5 * 60))
        
        let activity = ActivityContent(state: initialContentState, staleDate: .distantFuture)
                                                  
        do {
            let statusActivity = try Activity<BookCabAttributes>.request(
                attributes: orderCabAttributes,
                content: activity,
                pushType: nil)
            print("Requested a cab Live Activity \(statusActivity.id)")
        } catch (let error) {
            print("Error requesting a cab Live Activity \(error.localizedDescription)")
        }
    }
    func updateCabStatus() {
        Task {
            let updatedDeliveryStatus = BookCabAttributes.cabArrivalStatus(driverName: "Anmol", estimatedReachTime: Date()...Date().addingTimeInterval(20 * 60))
            
            for activity in Activity<BookCabAttributes>.activities{
                await activity.update(using: updatedDeliveryStatus)
            }
        }
    }
    func CancelCab() {
        Task {
            for activity in Activity<BookCabAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}
