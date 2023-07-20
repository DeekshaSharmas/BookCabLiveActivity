//
//  BookACabLiveActivity.swift
//  BookACab
//
//  Created by Deeksha Sharma on 7/19/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
   var body: some Widget {
       BookedCabActivity()
   }
}
struct BookedCabActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BookCabAttributes.self) { context in
            // For devices that don't support the Dynamic Island.
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(context.state.driverName) is on the way!")
                                .font(.headline)
                            Spacer()
                            Text("\(context.state.vechileNumber)")
                                .font(.title)
                                .bold()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.secondary)
                            HStack {
                                RoundedRectangle(cornerRadius: 15).fill(.blue).frame(width: 70)
                                Image(systemName: "car.side.fill").scaleEffect(x:-1,y:1.2)
                                    .foregroundColor(.white)
                                    .padding(.leading, -25)
                                Text(timerInterval: context.state.estimatedReachTime, countsDown: true).bold().font(.caption).foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white.opacity(0.5))
                                Image(systemName: "house.circle.fill")
                                    .foregroundColor(.green)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    Spacer()
                }.padding(5)
                HStack {
                    Text("Trip Amount: \(context.attributes.totalAmount)").font(.caption).foregroundColor(.secondary)
                        .padding(.horizontal, 5)
                    Spacer()
                    Text("OTP 1234").font(.subheadline)
            .bold()
                }
            }.padding(15)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.state.vechileNumber) ", systemImage: "car")
                        .font(.headline)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.estimatedReachTime, countsDown: true)
                            .multilineTextAlignment(.leading)
                            .frame(width: 50)
                            .monospacedDigit()
                            .font(.headline)
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is on the way!")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(spacing:10) {
                        Link(destination: URL(string: "tel:0000000000")!) {
                                                     Label("Contact driver", systemImage: "phone.circle.fill").padding()
                                                 }.background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 15)).font(.headline)
                        Button(action: { LiveActivityManager().CancelCab() }) {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                Text("Update Cab").font(.headline)
                                Spacer()
                            }.frame(height: 50)
                        }.tint(.white).background(.red).cornerRadius(15)
                    }.frame(maxWidth: UIScreen.main.bounds.size.width)
                }
            } compactLeading: {
                Label {
                    Text("\(context.state.vechileNumber)")
                } icon: {
                    Image(systemName: "car")
                }
                .font(.caption2)
            } compactTrailing: {
                HStack(alignment: .center){
                    Image(systemName: "clock")
                    Text(timerInterval: context.state.estimatedReachTime, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 40)
                        .font(.caption2)
                }
                
            } minimal: {
                VStack(alignment: .center) {
                    Text(timerInterval: context.state.estimatedReachTime, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.system(size: 10))
        
                }
            }
            .keylineTint(.accentColor)
        }
    }
}
@available(iOSApplicationExtension 16.2, *)
struct BookACabLiveActivity_Previews: PreviewProvider {
    static let attributes = BookCabAttributes(customerName: "Deeksha", totalAmount: "Rs. 450")
    static let contentState = BookCabAttributes.ContentState(driverName: "Anmol", vechileNumber: "UP2456", estimatedReachTime: Date()...Date().addingTimeInterval(15 * 60))

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact").previewDevice("iPhone 14 Pro Max")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded").previewDevice("iPhone 14 Pro Max")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal").previewDevice("iPhone 14 Pro Max")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification").previewDevice("iPhone 14 Pro Max")
    }
}
