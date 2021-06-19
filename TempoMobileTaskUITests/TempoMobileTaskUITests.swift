//
//  TempoMobileTaskUITests.swift
//  TempoMobileTaskUITests
//
//  Created by mina wefky on 17/06/2021.
//

import XCTest
@testable import TempoMobileTask

class TempoMobileTaskUITests: XCTestCase {
    var mockviewController: NewsListViewController!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.mockviewController = NewsListViewController.loadFromNib()
        self.mockviewController.loadView()
        self.mockviewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testHasATableView() {
        XCTAssertNotNil(mockviewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(mockviewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
           XCTAssertTrue(mockviewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(mockviewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(mockviewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(mockviewController.responds(to: #selector(mockviewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(mockviewController.responds(to: #selector(mockviewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
           let cell = mockviewController.tableView(mockviewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsTableViewCell
           let actualReuseIdentifer = cell?.reuseIdentifier
           let expectedReuseIdentifier = "NewsTableViewCell"
           XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
