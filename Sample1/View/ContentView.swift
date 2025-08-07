//
//  ContentView.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        TabView {
            CourselView()
            .tabItem {
                Label("Carousel", systemImage: "square.stack")
            }
            
            ListView()
            .tabItem {
                Label("List", systemImage: "list.bullet")
            }
        }
        .onAppear {
            if viewModel.productList.isEmpty {
                viewModel.getAllItems()
            }
        }
    }
}

#Preview {
    ContentView()
}
