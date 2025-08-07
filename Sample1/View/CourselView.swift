//
//  CourselView.swift
//  Sample1
//
//  Created by Rajesh Yadav on 07/08/25.
//

import SwiftUI

struct CourselView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
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
    }
}

#Preview {
    CourselView()
}
