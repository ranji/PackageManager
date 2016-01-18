//
//  PackageDependencyResolverTests.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/18/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import XCTest

class PackageDependencyResolverTests: XCTestCase {
    var packageDependencyResolver : PackageDependencyResolver!
    override func setUp() {
        super.setUp()
        packageDependencyResolver = PackageDependencyResolver(dependencyParser: PackageDependencyParser(), sorter : KahnsTopologicalSorter())
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_should_integrate_parser_and_sorter() {
       let packageList = ["Seat: Cloth" ,"Car: Engine","Cloth: ","Engine: Piston","Engine: Carburater", "Car: Seat","Piston: ","Carburater: "]
        let sortedDependencies = packageDependencyResolver.resolve(packageList)
        XCTAssertTrue(sortedDependencies?.count == 6)
    }

    func testPerformanceExample() {
        self.measureBlock {
            // TODO: Add a giant list of package dependencies here to set benchmarks
        }
    }

}
