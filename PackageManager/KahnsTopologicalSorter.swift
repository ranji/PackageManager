//
//  DependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation
protocol TopologicalSorting{
    func sort(packageSpecifications:[String:[String]]?) throws -> [String]?
}

class KahnsTopologicalSorter:TopologicalSorting {
    
    
    func sort(packageSpecifications:[String:[String]]?) throws -> [String]?{
        
        var sortedDependencies : [String]?
        
        guard let _ = packageSpecifications else{
            return sortedDependencies
        }
        
        var dependencySpecifications = packageSpecifications!
        
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
        
        var packageVertices = getPackagesWithNoDependencies(dependencySpecifications)
        
        sortedDependencies = [String]()
        
        for package in packageVertices{
            dependencySpecifications.removeValueForKey(package)
        }
        
        
        
        //while S is non-empty do
        while packageVertices.count > 0 {
            packageVertices.sortInPlace()
            
            //remove a node n from S
            let packageVertice = packageVertices.removeLast()
            
            //add n to L
            sortedDependencies?.append(packageVertice)
            
            for (package,dependencies) in dependencySpecifications{
                //get all packages dependent on given package -- edges from n -> m
                
                let dependentPackages = dependencies.filter({ $0 == packageVertice
                })
                
                if dependentPackages.count > 0 {
                    //remove edge e from the graph

                    dependencySpecifications[package] = dependencySpecifications[package]?.filter({$0 != packageVertice})
                    
                    // if m has no other incoming edges then insert m into S
                    if dependencySpecifications[package]?.count == 0 {
                        packageVertices.append(package)
                    }
                }
            }
            
        }
        
        let cyclicalReferences = dependencySpecifications.filter({ (package,dependencies) -> Bool in
            return dependencies != []
            })
        
        if cyclicalReferences.count>0{
            throw GraphError.CyclicDependencyDetected
        }
        
        return sortedDependencies
    }
    
    
    
    func getPackagesWithNoDependencies(packageSpecifications:[String:[String]])->[String]{
        var packages  = [String]()
        for (package,deps) in packageSpecifications{
            if deps == [] {
                packages.append(package)
            }
        }
        return packages
    }
    
    
}
