//
//  Sample1Tests.swift
//  Sample1Tests
//
//  Created by Rajesh Yadav on 04/08/25.
//

import XCTest
@testable import Sample1
import Combine

class MockDBManager: DBManager {
    var savedProducts: [Product] = []
    
    override func saveData(products: [Product]) {
        savedProducts = products
    }
    
    override func getAllItems() -> [Product] {
        return savedProducts
    }
}

class MockApiManager: ApiManager {
//    @Published override var isDataSaved: Bool = false
    var fetchCalled = false

    override func getProductList() {
        fetchCalled = true
    }
}


final class Sample1Tests: XCTestCase {

    var viewModel: ProductViewModel!
    var mockDB: MockDBManager!
    var mockAPI: MockApiManager!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockDB = MockDBManager()
        mockAPI = MockApiManager()
        viewModel = ProductViewModel(dbManager: mockDB, apiManager: mockAPI)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDB = nil
        mockAPI = nil
        cancellables = []
        super.tearDown()
    }
    
    
    func test_getAllItems_whenProductListIsEmpty_callsApiManager() {
            // Given
            viewModel.productList = []

            // When
            viewModel.getAllItems()

            // Then
            XCTAssertTrue(mockAPI.fetchCalled)
        }

        func test_getAllItems_whenProductListNotEmpty_doesNotCallApi() {
            // Given
            let sampleProduct = Product(id: 1, title: "Test", price: 10.0, description: "Test Desc", category: "TestCat", image: "", rating: Rating(count: 10, rate: 4.0))
            mockDB.savedProducts = [sampleProduct]
            viewModel.productList = [sampleProduct]

            // When
            viewModel.getAllItems()

            // Then
            XCTAssertEqual(viewModel.productList.count, 1)
            XCTAssertFalse(mockAPI.fetchCalled)
        }

        func test_productListUpdates_whenIsDataSavedChanges() {
            // Given
            let expectation = self.expectation(description: "Product list should update")
            let sampleProduct = Product(id: 1, title: "Test", price: 10.0, description: "Test Desc", category: "TestCat", image: "", rating: Rating(count: 10, rate: 4.0))
            mockDB.savedProducts = [sampleProduct]
            
            viewModel.$productList
                .dropFirst()
                .sink { updatedList in
                    XCTAssertEqual(updatedList.count, 1)
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            // When
//            mockAPI.isDataSaved = true

            // Then
            waitForExpectations(timeout: 1.0, handler: nil)
        }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
