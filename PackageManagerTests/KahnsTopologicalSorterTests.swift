//
//  DependencyResolverTests.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import XCTest

class KahnsTopologicalSorterTests: XCTestCase {
    
    var sorter : KahnsTopologicalSorter!
    
    override func setUp() {
        super.setUp()
        sorter =  KahnsTopologicalSorter()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_should_resolve_all_dependencies(){
        let dependencySpecifications = ["Car": ["Engine"], "Engine" :[]]

        let dependencies = try! sorter.sort(dependencySpecifications)
        
        XCTAssertEqual(dependencies?.count , 2)
    }
    
    func test_should_resolve_dependencies_in_order(){
        let dependencySpecifications = ["Car": ["Engine"], "Engine" :[]]
        let dependencies = try! sorter.sort(dependencySpecifications)
        
        XCTAssertNotNil(dependencies)
        
        if let dependencies = dependencies{
            XCTAssertEqual(dependencies, ["Engine","Car"])
        }
    }
    
    func test_should_resolve_packages_with_multiple_dependencies(){
        let specifications = [  "Car" : ["Engine","Seat"],
                                "Engine" : ["Carburater","Piston"],
                                "Carburater" : [],
                                "Piston" : [],
                                "Seat" : ["Cloth"],
                                "Cloth" : []]
        
        let dependencies = try! sorter.sort(specifications)
        
        XCTAssertNotNil(dependencies)
        
        if let dependencies = dependencies{
            let indexOfEngine = dependencies.indexOf("Engine")
            let indexOfPiston = dependencies.indexOf("Piston")
            let indexOfCar = dependencies.indexOf("Car")
            let indexOfCloth = dependencies.indexOf("Cloth")
            let indexOfSeat = dependencies.indexOf("Seat")
            XCTAssert(indexOfPiston < indexOfEngine)
            XCTAssert(indexOfEngine < indexOfCar)
            XCTAssert(indexOfCloth < indexOfSeat)
            
        }
    }
    
    func test_empty_specification_should_yeild_zero_dependencies(){
        let dependencies = try! sorter.sort(nil)
        XCTAssertNil(dependencies)
    }
    
    func test_there_should_be_no_cyclic_dependency_specification(){
        let specifications = [  "Car" : ["Engine"],
            "Engine" : ["Piston","Car" ],
            "Piston" : []]
        do {
            let _ = try sorter.sort(specifications)
        } catch GraphError.CyclicDependencyDetected{
            XCTAssertTrue(true)
        } catch{
            XCTAssertTrue(false)
        }
    }
    
    func test_can_identify_packages_with_no_dependencies(){
        let specifications = [  "Car" : ["Engine","Seat"],
            "Engine" : ["Carburater","Piston"],
            "Carburater" : [],
            "Piston" : [],
            "Seat" : ["Cloth"],
            "Cloth" : []]
        
        let packagesWithNoDependencies = sorter.getPackagesWithNoDependencies(specifications)
        
        XCTAssertEqual(packagesWithNoDependencies,["Cloth", "Carburater", "Piston"])
    }
    
    
}
