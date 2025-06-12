//
//  ContentView.swift
//  FindMyLab
//
//  Created by Claes Jacobsson on 2025-06-11.
//

import SwiftUI
import MapKit

struct ContentView: View {

    var body: some View {
        Map()
            .sheet(isPresented: Binding(projectedValue: .constant(true))) {
                CustomTabView()
                    .presentationDetents([.height(80), .medium, .large])
                    .presentationBackgroundInteraction(
                        .enabled(upThrough: .medium)
                    )
                    .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ContentView()
}


struct CustomTabView: View {

    @State private var selectedTab: CustomTab = .people

    var body: some View {
        VStack {
            tabContent

            // Custom expandable tab bar
            HStack {
                Group {
                    ForEach(CustomTab.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack {
                                Image(systemName: tab.icon)
                                Text(tab.title).font(.footnote)
                            }
                        }
                        .tint(selectedTab == tab ? .blue : .primary)
                    }
                }
                .font(.title2)
                .frame(maxWidth: .infinity)
            }
            .frame(height: 80)
        }
    }

    @ViewBuilder
    var tabContent: some View {
        switch selectedTab {
            case .people:
                NavigationView {
                    List {
                        ForEach(0..<20) {
                            Text("Person \($0)")
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .navigationTitle("People")
                }
            case .devices:
                NavigationView {
                    List {
                        ForEach(0..<20) {
                            Text("Device \($0)")
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Devices")
                }
            case .items:
                NavigationView {
                    List {
                        ForEach(0..<20) {
                            Text("Item \($0)")
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Items")
                }
            case .me:
                NavigationView {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    .navigationTitle("Me")
                }
        }
    }

}

enum CustomTab: CaseIterable {
    case people
    case devices
    case items
    case me

    var icon: String {
        switch self {
            case .people:
                return "figure.2"
            case .devices:
                return "macbook.and.iphone"
            case .items:
                return "circle.grid.2x2.fill"
            case .me:
                return "location.slash"
        }
    }

    var title: String {
        switch self {
            case .people:
                return "People"
            case .devices:
                return "Devices"
            case .items:
                return "Items"
            case .me:
                return "Me"
        }
    }
}
