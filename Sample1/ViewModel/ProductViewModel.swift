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
    var dbManager: DBManager
    var apiManager: ApiManager
    private var cancellables = Set<AnyCancellable>()

    init(dbManager: DBManager = DBManager(), apiManager: ApiManager = ApiManager()) {
        self.dbManager = dbManager
        self.apiManager = apiManager
        
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
