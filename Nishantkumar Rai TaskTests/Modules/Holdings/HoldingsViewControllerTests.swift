//
//  HoldingsViewControllerTests.swift
//  Nishantkumar Rai TaskTests
//
//  Created by Nishant Rai on 16/12/24.
//

import XCTest
@testable import Nishantkumar_Rai_Task

class HoldingsViewControllerTests: XCTest {
    var viewController: HoldingsViewController!
    var presenter: MockPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = HoldingsViewController()
        presenter = MockPresenter()
        viewController.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertTrue(presenter.didLoadHoldingsCalled)
    }
    
    func testDidTapOnHondingSumaryView() {
        viewController.didTapOnHondingSumaryView(UITapGestureRecognizer())
        
        XCTAssertTrue(presenter.didTapOnHoldingSummaryViewCalled)
    }
    
    func testShouldShowHoldingSummaryView() {
        viewController.shouldShowHoldingSummaryView(true)
        
        XCTAssertFalse(viewController.holdingsSummaryView.isHidden)
        XCTAssertEqual(viewController.holdingsSummaryView.alpha, 1.0)
    }
    
    func testShowHoldings() {
        // Test Data
        let testHoldings = [
           UserHoldings(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40)
        ]
        
        viewController.showHoldings(testHoldings)
        
        XCTAssertEqual(viewController.holdings.count, 1)
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), testHoldings.count)
    }
    
    func testShowError() {
        let errorMessage = "Please try again!"
        
        viewController.showError(errorMessage)
        
        XCTAssertEqual(viewController.presentedViewController as? UIAlertController, viewController.presentedViewController)
        XCTAssertEqual((viewController.presentedViewController as? UIAlertController)?.message, errorMessage)
    }
    
    func testShowHoldingsSumary() {
        // Test Data
        let testHoldings = [
           BottomSheetModel(title: "Current value", value: "1000")
        ]
        let totalPNLTitle = "Total P&L"
        let totalPNL = "2000"
        viewController.showHoldingsSumary(holdingsSummary: testHoldings, totalPNLTitle: totalPNLTitle, totalPNL: totalPNL)
        
        XCTAssertEqual(viewController.holdingsSummary.count, 1)
    }
}
