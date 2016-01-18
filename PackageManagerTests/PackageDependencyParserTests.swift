//
//  DependencyParser.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import XCTest

class PackageDependencyParserTests: XCTestCase {
    
    var dependencyParser: PackageDependencyParser!
    
    override func setUp() {
        super.setUp()
        dependencyParser = PackageDependencyParser()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_should_parse_array_to_graph() {
        let packageList = ["Car: Engine","Engine: Piston","Engine: Carburater", "Piston: ","Carburater: "]
        let packageDependencyGraph = dependencyParser.createDependencyGraph(packageList)
        
        XCTAssertEqual(4, packageDependencyGraph?.count)
    }
    
    func test_should_throw_if_array_is_not_in_correct_format(){
        let packageList = [": Engine"]
        let packageDependencyGraph = dependencyParser.createDependencyGraph(packageList)
        
        XCTAssertTrue(false)
        
    }

    

}
