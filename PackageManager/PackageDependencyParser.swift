//
//  DependencyParser.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/18/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

protocol PackageDependencyParsingProtocol{
    func createDependencyGraph(packageDependencySpecifications:[String]) throws ->[String:[String]]?
}

class PackageDependencyParser : PackageDependencyParsingProtocol{
    func createDependencyGraph(packageDependencySpecifications:[String]) throws ->[String:[String]]?{
        var graph = [String:[String]]()
        for specification in packageDependencySpecifications{
            let parts = specification.componentsSeparatedByString(": ")
            
            if parts.count != 2{
                throw GraphError.WrongSpecificationFormat("\(specification) format is incorrect")
            }
            
            let packageName = parts[0]
            
            if packageName.isEmpty{
                throw GraphError.WrongSpecificationFormat("\(specification) format is incorrect")
            }
            
            let dependency = parts[1]
            
            
            if graph.keys.contains(packageName) == false{
                graph[packageName] = []
            }
            
            if graph[packageName]?.contains(dependency) ==  false && dependency.isEmpty == false{
                graph[packageName]?.append(dependency)
            }
        }
        
        return graph
    }
}
