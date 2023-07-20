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
        let orderCabAttributes = BookCabAttributes(customerName: "Deeksha", totalAmount: "Rs. 450")

        let initialContentState = BookCabAttributes.ContentState(driverName: "Anmol", vechileNumber: "UP2345", estimatedReachTime: Date()...Date().addingTimeInterval(5 * 60))
        
        let activity = ActivityContent(state: initialContentState, staleDate: .now)
                                                  
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
            let updatedDeliveryStatus = BookCabAttributes.ContentState(driverName: "Anmol", vechileNumber: "UP2345", estimatedReachTime: Date()...Date().addingTimeInterval(20 * 60))
            let activityState = ActivityContent(state: updatedDeliveryStatus, staleDate: .now)
            
            for activity in Activity<BookCabAttributes>.activities{
                await activity.update(activityState)
            }
        }
    }
    func CancelCab() {
        Task {
            for activity in Activity<BookCabAttributes>.activities{
                await activity.end(nil,dismissalPolicy:.immediate) // content state set to nil
            }
        }
    }
}
