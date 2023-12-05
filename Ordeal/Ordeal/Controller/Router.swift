//
//  Router.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 04/12/23.
//

import SwiftUI


class Router: ObservableObject {
    @Published var path: [String]
    
    init() {
        self.path = []
    }
    
    
    func reset() {
        path = []
    }
}

