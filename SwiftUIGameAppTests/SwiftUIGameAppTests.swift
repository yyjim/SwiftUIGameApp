//
//  SwiftUISnakeAppTests.swift
//  SwiftUISnakeAppTests
//
//  Created by yyjim on 2020/7/1.
//

import XCTest
@testable import SwiftUISnakeApp

class SwiftUISnakeAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mineSweeper = MineSweeper(rows: 10, cols: 10, numberOfBombs: 5)
        XCTAssertEqual(mineSweeper.neighbors(of: 0), [10, 1, 11])
        XCTAssertEqual(mineSweeper.neighbors(of: 11), [0, 10, 20, 1, 21, 2, 12, 22])
        XCTAssertEqual(mineSweeper.neighbors(of: 9), [8, 18, 19])
        XCTAssertEqual(mineSweeper.neighbors(of: 99), [88, 98, 89])

        assert(mineSweeper: mineSweeper, index: 0, xy: (0, 0))
        assert(mineSweeper: mineSweeper, index: 1, xy: (1, 0))
        assert(mineSweeper: mineSweeper, index: 9, xy: (9, 0))
        assert(mineSweeper: mineSweeper, index: 10, xy: (0, 1))
        assert(mineSweeper: mineSweeper, index: 99, xy: (9, 9))
    }

    private func assert(mineSweeper: MineSweeper, index: Int, xy: (x: Int, y: Int)) {
        let (x, y) = mineSweeper.xy(of: index)
        XCTAssertEqual(x, xy.x)
        XCTAssertEqual(y, xy.y)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
