//
//  HoldingsInteractorTests.swift
//  Nishantkumar Rai TaskTests
//
//  Created by Nishant Rai on 15/12/24.
//

import XCTest
@testable import Nishantkumar_Rai_Task

final class HoldingsInteractorTests: XCTestCase {
    var interactor: HoldingsInteractor!
    var presenter: MockPresenter!
    var coreDataService: MockCoreDataService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = MockPresenter()
        coreDataService = MockCoreDataService()
        interactor = HoldingsInteractor(presenter: presenter, coreDataService: coreDataService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        presenter = nil
        coreDataService = nil
    }

    func testGetHoldingsSummary() {
        // Test Data
        let testHoldings = [
           UserHoldings(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40)
        ]
        interactor.getHoldingsSummary(testHoldings)
        
        XCTAssertTrue(presenter.didCalculateHoldingsSummaryCalled)
        XCTAssertEqual(presenter.currentValue, 37669.5)
        XCTAssertEqual(presenter.totalInvesment, 34650.0)
        XCTAssertEqual(presenter.todaysPNL, 1930.5000000000027)
        XCTAssertEqual(presenter.totalPNL, 3019.5)
    }
}
class MockPresenter: HoldingsPresenterProtocol {
    var didFailToFetchHoldingsCalled = false
    var didLoadHoldingsCalled = false
    var didFetchHoldingsCalled = false
    var didCalculateHoldingsSummaryCalled = false
    var didTapOnHoldingSummaryViewCalled = false
    var currentValue: Double?
    var totalInvesment: Double?
    var totalPNL: Double?
    var todaysPNL: Double?
    var fetchError: APIError?
    
    func loadHoldings() {
        didLoadHoldingsCalled = true
    }
    
    func didFailToFetchHoldings(error: Nishantkumar_Rai_Task.APIError) {
        didFailToFetchHoldingsCalled = true
        fetchError = error
    }
    
    func didFetchHoldings(holdings: [Nishantkumar_Rai_Task.UserHoldings]) {
        didFetchHoldingsCalled = true
    }
    
    func didCalculateHoldingsSummary(currentValue: Double, totalInvesment: Double, toalPNL: Double, todaysPNL: Double) {
        didCalculateHoldingsSummaryCalled = true
        self.currentValue = currentValue
        self.totalInvesment = totalInvesment
        self.totalPNL = toalPNL
        self.todaysPNL = todaysPNL
    }
    
    func didTapOnHoldingSummaryView() {
        didTapOnHoldingSummaryViewCalled = true
    }
}
    
class MockCoreDataService: CoreDataServiceProtocol {
    var cachedHoldings: [UserHoldings] = []
    var didSaveCalled = false
    func save(data: [Nishantkumar_Rai_Task.UserHoldings]) {
        didSaveCalled = true
    }
    
    func fetchCachedData() -> [Nishantkumar_Rai_Task.UserHoldings] {
        return cachedHoldings
    }
}
