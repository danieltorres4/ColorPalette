//
//  ContentView.swift
//  ColorPalette
//
//  Created by Iván Sánchez Torres on 02/03/23.
//

import SwiftUI

struct MainView: View {
    @State var isPresented: Bool = false
    @ObservedObject var colorExampleViewModel: ColorExampleViewModel
    private let pasteboard = UIPasteboard.general
    @State var myText: String = ""
    
    var elements = 1...4
    let gridItems = [GridItem(.fixed(100)),
                     GridItem(.fixed(100))]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, content: {
                        ForEach(elements, id: \.self) { element in
                            ColorView(colorExampleViewModel: colorExampleViewModel)
                                .padding()
                        }
                    })
                }
                
                Label("Tap the rectangle to copy the hex value", systemImage: "hand.tap.fill")
                    .font(.title)
                    .bold()
                    .italic()
            }
            .navigationTitle("Color Palette")
            .background(Color.secondary)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(colorExampleViewModel: ColorExampleViewModel())
    }
}
