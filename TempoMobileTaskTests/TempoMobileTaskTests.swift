//
//  TempoMobileTaskTests.swift
//  TempoMobileTaskTests
//
//  Created by mina wefky on 17/06/2021.
//

import XCTest
import RxSwift

@testable import TempoMobileTask

class TempoMobileTaskTests: XCTestCase {
    var mockNetwork: ApiClient!
    let disposeBag = DisposeBag()
    override func setUpWithError() throws {
        //        mockNetwork = ApiClient.shared
    }
    
    override func tearDownWithError() throws {
        mockNetwork = nil
        super.tearDown()
    }
    
    func testValidateNetWorkCallsForVenue() {
        
        let promise = expectation(description: "Status code: 200")
        ApiClient.getNews(searchText: "Apple", page: 1)
            .subscribe(onNext: { _ in
                promise.fulfill()
            }, onError: { (error) in
                XCTFail("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 5)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
