//
//  ContentView.swift
//  Plantifer
//
//  Created by Parth Sharma on 8/21/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: MainMenu()){
                    Image("p").resizable().frame(width: 69, height: 69)
                }
                Text("Welcome to Plantifer!").font(.largeTitle)
                Text("Tap the plant to get started!").font(.headline)
            }
            .padding()
        }
    }
}

#Preview {
    Home()
}
