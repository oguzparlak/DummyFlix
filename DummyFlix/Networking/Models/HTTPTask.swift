//
//  HTTPTask.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

public enum HTTPTask {

    case request
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)

}
