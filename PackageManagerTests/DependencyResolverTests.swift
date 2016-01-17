//
//  DependencyResolverTests.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import XCTest

class DependencyResolverTests: XCTestCase {
    
    var dependencyResolver : DependencyResolver!
    
    override func setUp() {
        super.setUp()
        dependencyResolver =  DependencyResolver()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_should_accept_dependency_specifications_as_dictionary() {
        
        let dependencySpecifications = ["Car":["Engine"],"Engine":[]]
        dependencyResolver.resolve(dependencySpecifications)
        
        XCTAssert(dependencyResolver.dependencySpeicfications != nil)
        XCTAssert(dependencyResolver.dependencySpeicfications!.count == 2,  "expected count 2 , was \([dependencyResolver.dependencySpeicfications!.count])")
    }
    
    func test_resolve_should_return_all_dependencies(){
        let dependencySpecifications = ["Car":["Engine"],"Engine":[]]
        let dependencies = dependencyResolver.resolve(dependencySpecifications)
        XCTAssert(dependencies?.count == 2)
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
