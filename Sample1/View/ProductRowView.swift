//
//  ProductRowView.swift
//  Sample1
//
//  Created by Rajesh Yadav on 06/08/25.
//

import SwiftUI

struct ProductRowView: View {
    var product: Product
    var body: some View {
        VStack {
            Text(product.title)
                .padding()
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 250)
            .clipped()
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    ProductRowView(product: Product(id: 1, title: "test", price: 0.0, description: "test desc", category: "test1", image: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg", rating: Rating(count: 1, rate: 0.01)))
}
