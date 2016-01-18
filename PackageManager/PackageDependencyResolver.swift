//
//  PackageDependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/18/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class PackageDependencyResolver {
    let dependencyParser:PackageDependencyParsingProtocol
    let sorter:TopologicalSortingProtocol
    
    init(dependencyParser:PackageDependencyParsingProtocol, sorter:TopologicalSortingProtocol){
        self.dependencyParser = dependencyParser
        self.sorter = sorter
    }
    
    func resolve (packageList:[String]) -> [String]?{
        var sortedPackageDependencies : [String]?
        do{
            let packageSpecificationGraph = try self.dependencyParser.createDependencyGraph(packageList)
            sortedPackageDependencies = try self.sorter.sort(packageSpecificationGraph)
            
        }catch GraphError.WrongSpecificationFormat(let errorMessage){
            print(errorMessage)
        }catch GraphError.CyclicDependencyDetected(let errorMessage){
            print(errorMessage)
        }
        catch{
            print("unexpected error")
        }
        return sortedPackageDependencies
        
    }
}