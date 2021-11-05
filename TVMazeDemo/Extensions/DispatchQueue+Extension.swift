//
//  DispatchQueue+Extension.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import Foundation

extension DispatchQueue {
    static let networking = DispatchQueue(label: "com.legd.TVMazeDemo", qos: .userInitiated, attributes: .concurrent)
}
