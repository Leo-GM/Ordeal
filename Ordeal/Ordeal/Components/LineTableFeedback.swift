//
//  LineTableFeedback.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 23/11/23.
//

import SwiftUI

struct LineTableFeedback: View {
    @State var icon: String
    @State var iconColor: String
    @State var idealValue: Int
    @State var valueReceived: Int
    @State var lineTitle: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(Color(iconColor) )
            .font(.body)
        
        Text(lineTitle)
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
            .padding(.leading, 8)

        
        Spacer()
        
        Text("\(valueReceived)")
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
        
        Spacer()
        
        Text("\(idealValue)")
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
    }
}


//
//  LineTableFeedback.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 23/11/23.
//

import SwiftUI

struct LineTableFeedback2: View {
    @State var icon: String
    @State var iconColor: String
    @State var idealValue: Int
    @State var valueReceived: Int
    @State var lineTitle: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(Color(iconColor) )
            .font(.body)
        
        Text(lineTitle)
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
            .padding(.leading, 8)

        
        Spacer()
        
        Text("--")
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
        
        Spacer()
        
        Text("--")
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .fontDesign(.rounded)
    }
}
