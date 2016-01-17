//
//  DependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class DependencyResolver {
    var dependencySpeicfications : [String:[String]?]?
    
    func resolve(dependencySpecifications:[String:[String]?]?) -> [String]?{
        self.dependencySpeicfications = dependencySpecifications
        return nil
    }
}
