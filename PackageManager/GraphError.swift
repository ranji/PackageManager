//
//  DependencySpecification.swift
//  PackageManager
//
//  Created by RANJIT THAYYIL on 1/17/16.
//  Copyright © 2016 freehub. All rights reserved.
//

import Foundation

enum GraphError:ErrorType{
    case CyclicDependencyDetected(String)
    case WrongSpecificationFormat(String)
}