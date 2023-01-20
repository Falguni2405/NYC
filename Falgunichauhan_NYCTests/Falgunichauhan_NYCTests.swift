//
//  Falgunichauhan_NYCTests.swift
//  Falgunichauhan_NYCTests
//
//  Created by Falguni Chauhan on 1/19/23.
//

import XCTest
import SwiftUI

@testable import Falgunichauhan_NYC

final class Falgunichauhan_NYCTests: XCTestCase {
    @ObservedObject var viewModel: NYCSchoolViewModel = NYCSchoolViewModel()

    func testGetData() {
        let expectation = XCTestExpectation(description: "Must return true")
        let viewModel = viewModel

        viewModel.getData { success in
            if success {
                expectation.fulfill()
            } else {
                XCTFail("Couldn't get data")
            }
        }
    }

    func testGetSatData() {
        let expectation = XCTestExpectation(description: "Must return true")
        let viewModel = viewModel

        viewModel.getSatData(with: "21K728") { success in
            if success {
                expectation.fulfill()
            } else {
                XCTFail("Couldn't get data")
            }
        }
    }
}
