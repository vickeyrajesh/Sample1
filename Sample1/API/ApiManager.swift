//
//  ApiManager.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

// https://fakestoreapi.com/products

import Foundation
import Combine

class ApiManager {
    
    private var cancellable = Set<AnyCancellable>()
    let dbManager: DBManager = DBManager()
        
    @Published var isDataSaved: Bool = false

    func getProductList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: "http://localhost:3000/products")!)
            .map(\.data)
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint(error)
                }
            } receiveValue: { [weak self] products in
                DispatchQueue.global(qos: .userInitiated).async {
                    self?.dbManager.saveData(products: products)
                    DispatchQueue.main.async { [weak self] in
                        self?.isDataSaved = true
                    }
                }
            }
            .store(in: &cancellable)
    }
    
}
