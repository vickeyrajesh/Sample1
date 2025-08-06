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
            NavigationStack {
                if viewModel.productList.isEmpty {
                    ProgressView("loading...")
                } else {
                    TabView {
                        ForEach(viewModel.productList) { product in
                            NavigationLink(destination: ProductDetailsView(product: product)) {
                                ProductRowView(product: product)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .navigationTitle("Carousel")
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 280)
                }
            }
            .tabItem {
                Label("Carousel", systemImage: "square.stack")
            }
            
            NavigationStack {
                List(viewModel.productList) { product in
                    NavigationLink(destination: ProductDetailsView(product: product)) {
                        Text(product.title)
                    }
                }
                .navigationTitle("Product List")
            }
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
