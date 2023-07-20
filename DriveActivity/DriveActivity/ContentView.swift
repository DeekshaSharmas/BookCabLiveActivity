//
//  ContentView.swift
//  DriveActivity
//
//  Created by Deeksha Sharma on 7/19/23.
//

import SwiftUI
import ActivityKit
struct ContentView: View {
    
    // MARK: - Layout
    var body: some View {
        NavigationView {
            ZStack {
                actionButtons.padding(10)
            }
            .navigationTitle("Book A Cab")
            .preferredColorScheme(.light)
        }
    }
    
    var actionButtons: some View {
        VStack(spacing:10) {
            Spacer()
            HStack(spacing:10) {
                Button(action: { LiveActivityManager().startBookingCab() }) {
                    HStack {
                        Spacer()
                        Text("Book A Cab").font(.body)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.indigo).cornerRadius(15)
                Button(action: { LiveActivityManager().updateCabStatus() }) {
                    HStack {
                        Spacer()
                        Text("Update Cab").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.orange).cornerRadius(15)
            }.frame(maxWidth: UIScreen.main.bounds.size.width)
            Button(action: { LiveActivityManager().CancelCab() }) {
                HStack {
                    Spacer()
                    Text("Cancel Cab").font(.headline)
                    Spacer()
                }.frame(height: 60)
                .padding(.bottom)
            }.tint(.red).cornerRadius(15)
            Spacer()
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 0))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 14 Pro Max")
    }
}
