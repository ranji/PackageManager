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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_should_parse_array_to_graph() {
        let packageList = ["Car: Engine","Engine: Piston","Engine: Carburater", "Piston: ","Carburater: "]
        let graph = try! dependencyParser.createDependencyGraph(packageList)
        
        XCTAssertEqual(4, graph?.count)
        
        XCTAssertEqual(graph!["Car"]!,["Engine"])
        XCTAssertEqual(graph!["Piston"]!,[""])
        XCTAssertEqual(graph!["Engine"]!,["Piston","Carburater"])
    }
    
    func test_should_throw_if_array_is_not_in_correct_format(){
        let packageList = [": Engine"]
        
        do {
            let graph =  try dependencyParser.createDependencyGraph(packageList)
            XCTAssertTrue(graph?.count == 0)
        }catch GraphError.WrongSpecificationFormat{
            XCTAssertTrue(true)
        }
        catch{
            XCTAssertTrue(false)
        }
    }
    
    func test_should_throw_if_an_empty_string_is_passed_for_specification(){
        let packageList = [""]
        
        do {
            let graph =  try dependencyParser.createDependencyGraph(packageList)
            XCTAssertTrue(graph?.count == 0)
        }catch GraphError.WrongSpecificationFormat{
            XCTAssertTrue(true)
        }
        catch{
            XCTAssertTrue(false)
        }
        
        
        
    }
    
    
    
}
