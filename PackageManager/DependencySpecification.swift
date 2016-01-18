//
//  DependencySpecification.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

class DependencySpecification {
    var packageName: String
    var dependency: String
    
    init(packageName:String, dependency:String = ""){
        self.packageName = packageName
        self.dependency = dependency
    }
}

enum GraphError:ErrorType{
    case CyclicDependencyDetected
}