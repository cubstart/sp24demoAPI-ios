//
//  ContentView.swift
//  quoteAPIDemo
//
//  Created by Andy Huang on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Quote of the day:\n\(viewModel.fetchedQuote?.content ?? "")")
                .font(.title)
                .multilineTextAlignment(.center)
            
            Button(action: {viewModel.fetchQuote()}, label: {
                Text("Get a quote!")
            })
            .font(.title)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
