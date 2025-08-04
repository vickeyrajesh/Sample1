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
        NavigationStack {
            if viewModel.productList.isEmpty {
                ProgressView("loading...")
            } else {
                List (viewModel.productList) { product in
                    NavigationLink(destination: ProductDetailsView(product: product)) {
                        Text(product.title)
                    }
                }.navigationTitle("Products")
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
