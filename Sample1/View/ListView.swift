//
//  ListView.swift
//  Sample1
//
//  Created by Rajesh Yadav on 07/08/25.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.productList) { product in
                NavigationLink(destination: ProductDetailsView(product: product)) {
                    Text(product.title)
                }
            }
            .navigationTitle("Product List")
        }
    }
}

#Preview {
    ListView()
}
