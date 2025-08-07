//
//  DBManager.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import Foundation
import CoreData

class DBManager {
    
    func saveData(products: [Product]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProduct")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.context.execute(deleteRequest)
        } catch {
            debugPrint(error)
        }
        
        for product in products {
            let cdProduct = CDProduct(context: PersistenceController.shared.context)
            cdProduct.id = product.id
            cdProduct.title = product.title
            cdProduct.prodDesc = product.description
            cdProduct.price = product.price
            cdProduct.image = "https://json-server.dev/ai-profiles/99.png" //product.image
            cdProduct.category = product.category
            
            let cdRating = CDRating(context: PersistenceController.shared.context)
            cdRating.rate = product.rating.rate
            cdRating.count = product.rating.count
            
            cdProduct.toRating = cdRating
        }
        
        do {
            try PersistenceController.shared.context.save()
        } catch {
            debugPrint(error)
        }
        
    }
    
    func getAllItems() -> [Product] {
        do {
            var products: [Product] = []
            
            let cdProducts = try PersistenceController.shared.context.fetch(CDProduct.fetchRequest())
            cdProducts.forEach { cdProduct in
                products.append(self.convertToProductFromCDProduct(cdProduct: cdProduct))
            }
            return products
        } catch {
            debugPrint(error)
        }
        return []
    }

    func deleteItems(offsets: IndexSet) {
        
    }
    
    private func convertToProductFromCDProduct(cdProduct: CDProduct) -> Product {
        return Product(id: cdProduct.id, title: cdProduct.title ?? "", price: cdProduct.price, description: cdProduct.prodDesc ?? "", category: cdProduct.category ?? "", image: "https://json-server.dev/ai-profiles/99.png", rating: convertToRatingFromCDRating(cdRating: cdProduct.toRating!))
    }
    
    private func convertToRatingFromCDRating(cdRating: CDRating) -> Rating {
        return Rating(count: cdRating.count, rate: cdRating.rate)
    }
}
