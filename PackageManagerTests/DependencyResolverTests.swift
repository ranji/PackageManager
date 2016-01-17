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
        
        XCTAssert(dependencyResolver.dependencySpecifications != nil)
        XCTAssertEqual(dependencyResolver.dependencySpecifications!.count , 2,  "expected count 2 , was \([dependencyResolver.dependencySpecifications!.count])")
    }
    
    func test_should_resolve_all_dependencies(){
        let dependencySpecifications = ["Car":["Engine"],"Engine":[]]
        let dependencies = dependencyResolver.resolve(dependencySpecifications)
        
        XCTAssertEqual(dependencies?.count , 2)
    }
    
    func test_should_resolve_dependencies_in_order(){
        let dependencySpecifications = ["Car":["Engine"],"Engine":[]]
        let dependencies = dependencyResolver.resolve(dependencySpecifications)
        
        XCTAssertNotNil(dependencies)
        
        if let dependencies = dependencies{
            XCTAssertEqual(dependencies, ["Engine","Car"])
        }
    }
    
    func test_empty_specification_should_yeild_zero_dependencies(){
        let dependencies = dependencyResolver.resolve(nil)
        XCTAssertNil(dependencies)
    }
    
    func test_dependency_should_appear_only_once_in_resolved_dependencies(){
        XCTAssertTrue(false)
    }
    
    func test_there_should_be_no_cyclic_dependency_specification(){
        XCTAssertTrue(false)
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
