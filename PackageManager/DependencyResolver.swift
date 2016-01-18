//
//  DependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class DependencyResolver {
    
    func resolve(packageSpecifications:[DependencySpecification]?) -> [String]?{
        var dependencySpecifications = packageSpecifications
        
        var dependencies : [String]?
        
        guard let specifications = dependencySpecifications else{
            return dependencies
        }
        
        dependencies = Array<String>()
        
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
        
        let noDependencyPackages = getPackagesWithNoDependencies(specifications)
        dependencySpecifications = dependencySpecifications?.filter({ (spec) -> Bool in
            return spec.dependency != ""
        })
        
        // n in S
        for noDependencyPackage in noDependencyPackages{
            //add n to L
            dependencies?.append(noDependencyPackage)
            //get all packages dependent on given package -- edges from n -> m
            let dependentPackageSpecs = dependencySpecifications?.filter({ (spec) -> Bool in
               return spec.dependency == noDependencyPackage
            })
            guard let dependentPackages = dependentPackageSpecs else{
                break
            }
            
            for spec in dependentPackages{
                let otherDependencies = dependencySpecifications?.filter({ (specification) -> Bool in
                    return specification.packageName == spec.packageName && specification.dependency != spec.dependency
                })
                
                dependencySpecifications  = dependencySpecifications?.filter({ (specification) -> Bool in
                    return spec.packageName != specification.packageName && spec.dependency != specification.dependency
                })
                
                if otherDependencies?.count == 0 {
                    dependencies?.append(spec.packageName)
                }
            }
        }
        
        return dependencies
    }
    
    
    
    func getPackagesWithNoDependencies(dependencySpecifications:[DependencySpecification])->Set<String>{
        var packageSet  = Set<String>()
        for specification in dependencySpecifications{
            if specification.dependency.isEmpty{
                packageSet.insert(specification.packageName)
            }
        }
        return packageSet
    }
    
    
}
