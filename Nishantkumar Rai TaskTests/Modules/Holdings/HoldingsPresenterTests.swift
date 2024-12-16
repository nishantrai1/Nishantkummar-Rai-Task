//
//  HoldingsPresenterTests.swift
//  Nishantkumar Rai TaskTests
//
//  Created by Nishant Rai on 16/12/24.
//

import XCTest
@testable import Nishantkumar_Rai_Task

class HoldingsPresenterTests: XCTest {
    var view: MockHoldingView!
    var interactor: MockInteractor!
    var presenter: HoldingsPresenter!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MockHoldingView()
        interactor = MockInteractor()
        presenter.view = view
        presenter.interactor = interactor
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func testLoadHoldings() {
        presenter.loadHoldings()
        
        XCTAssertTrue(interactor.didFetchHoldingsCalled)
    }
    
    func testDidFailToFetchHoldings() {
        // Test data
        let error = APIError.networkUnavailable(reason: "No internet connection")
        
        presenter.didFailToFetchHoldings(error: error)
        
        XCTAssertTrue(view.didShowErrorCalled)
        XCTAssertEqual(view.errorMessage, error.localizedErrorDescription)
    }
    
    func testDidFetchHoldings() {
        // Test data
        let testHoldings = [
           UserHoldings(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40)
        ]
        
        presenter.didFetchHoldings(holdings: testHoldings)
        
        XCTAssertTrue(view.didShowHoldingsCalled)
        XCTAssertEqual(view.holdings?.count, 1)
    }
    
    func testDidCalculateHoldingsSummary() {
        presenter.didCalculateHoldingsSummary(currentValue: 10, totalInvesment: 100, toalPNL: 200, todaysPNL: 200)
        XCTAssertTrue(view.didShowHoldingsSumaryCalled)
        XCTAssertEqual(view.holdingsSummary?.count, 3)
        XCTAssertEqual(view.totalPNLTitle, "")
        XCTAssertEqual(view.totalPNL, "")
    }
    
    func testDidTapOnHoldingSummaryView() {
        presenter.didTapOnHoldingSummaryView()
        
        XCTAssertTrue(view.didShouldShowHoldingSummaryViewCalled)
        XCTAssertTrue(view.isHoldingsSummaryVisible)
        
        presenter.didTapOnHoldingSummaryView()
        XCTAssertFalse(view.isHoldingsSummaryVisible)
    }
}

class MockHoldingView: HoldingsViewProtocol {
    var didShowHoldingsCalled = false
    var didShowErrorCalled = false
    var didShowHoldingsSumaryCalled = false
    var didShouldShowHoldingSummaryViewCalled = false
    
    var errorMessage: String?
    var holdings: [UserHoldings]?
    var totalPNLTitle: String?
    var totalPNL: String?
    var isHoldingsSummaryVisible = false
    var holdingsSummary: [BottomSheetModel]?
    
    func showHoldings(_ holdings: [Nishantkumar_Rai_Task.UserHoldings]) {
        didShowHoldingsCalled = true
        self.holdings = holdings
    }
    
    func showError(_ errorMessage: String) {
        didShowErrorCalled = true
        self.errorMessage = errorMessage
    }
    
    func showHoldingsSumary(holdingsSummary: [Nishantkumar_Rai_Task.BottomSheetModel], totalPNLTitle: String, totalPNL: String) {
        didShowHoldingsSumaryCalled = true
        self.holdingsSummary = holdingsSummary
        self.totalPNLTitle = totalPNLTitle
        self.totalPNL = totalPNL
    }
    
    func shouldShowHoldingSummaryView(_ shouldShow: Bool) {
        didShouldShowHoldingSummaryViewCalled = true
        isHoldingsSummaryVisible = shouldShow
    }
}

class MockInteractor: HoldingsInteractorProtocol {
    var didFetchHoldingsCalled = false
    var didGetHoldingsSummaryCalled = false
    
    func fetchHoldings() {
        didFetchHoldingsCalled = true
    }
    
    func getHoldingsSummary(_ holdings: [Nishantkumar_Rai_Task.UserHoldings]) {
        didGetHoldingsSummaryCalled = true
    }
}
