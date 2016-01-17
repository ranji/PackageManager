//
//  DependencyResolver.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class DependencyResolver {
    var dependencySpecifications : [String:[String]?]?
    
    func resolve(dependencySpecifications:[String:[String]?]?) -> [String]?{
        self.dependencySpecifications = dependencySpecifications
        return nil
    }
}
