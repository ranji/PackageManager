//
//  DependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class DependencyResolver {
    var dependencySpecifications : [DependencySpecification]?
    
    func resolve(dependencySpecifications:[DependencySpecification]?) -> [String]?{
        self.dependencySpecifications = dependencySpecifications
        
        var dependencies : [String]?
        
        guard let specifications = dependencySpecifications else{
            return dependencies
        }
        
        
        /*
        L ← Empty list that will contain the sorted elements
        S ← Set of all nodes with no incoming edges
        while S is non-empty do
        remove a node n from S
        add n to tail of L
        for each node m with an edge e from n to m do
        remove edge e from the graph
        if m has no other incoming edges then
        insert m into S
        if graph has edges then
        return error (graph has at least one cycle)
        else
        return L (a topologically sorted order)
        */
        return dependencies
    }
    
    func getPackagesWithNoDependencies(dependencySpecifications:[DependencySpecification])->[String]{
        var packageSet  = Set<String>()
        for specification in dependencySpecifications{
            if specification.dependency.isEmpty{
                packageSet.insert(specification.packageName)
            }
        }
        let packageArray = Array(packageSet)
        return packageArray
    }
}
