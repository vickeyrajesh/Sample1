//
//  ProductViewModel.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var productList: [Product] = []
    let dbManager: DBManager = DBManager()
    let apiManager: ApiManager = ApiManager()
    private var cancellables = Set<AnyCancellable>()

    init() {
        apiManager.$isDataSaved
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.productList = self?.dbManager.getAllItems() ?? []
            }
            .store(in: &cancellables)
    }
    
    func getAllItems() {
        if productList.isEmpty {
            apiManager.getProductList()
        } else {
            productList = dbManager.getAllItems()
        }
    }
}
