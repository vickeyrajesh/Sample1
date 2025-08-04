//
//  ProductDetailsView.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Product?
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: product!.image)!) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .padding()
                .frame(width: 300, height: 300)
                
                Text(product?.description ?? "")
                    .font(.subheadline)
                Text(product?.category ?? "")
                Text(String(format: "%.2f", product?.price ?? 0.0))
                Text(String(format: "%.2f", product?.rating.rate ?? 0.0))
                Text("Product Count: \(product?.rating.count ?? 0)")
                Spacer()
            }
            .padding()
            .navigationTitle(product?.title ?? "aa")
        }
    }
}

#Preview {
    ProductDetailsView(product: Product(id: 1, title: "test", price: 0.0, description: "test desc", category: "test1", image: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg", rating: Rating(count: 1, rate: 0.01)))
}
