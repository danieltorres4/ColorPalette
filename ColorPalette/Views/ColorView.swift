//
//  ColorView.swift
//  ColorPalette
//
//  Created by Iván Sánchez Torres on 02/03/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ColorView: View {
    @State var isPresented: Bool = false
    @ObservedObject var colorExampleViewModel: ColorExampleViewModel
    @State var myText: String = ""
    private let pasteboard = UIPasteboard.general
    
    var elements = 1...4
    let gridItems = [GridItem(.fixed(100)),
                     GridItem(.fixed(100))]

    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .foregroundColor(colorExampleViewModel.drawSwiftUIColor)
                    .frame(width: 60, height: 90)
                    .gesture(
                        TapGesture()
                            .onEnded({ _ in
                                print("The hex value has been copied!\n")
                                isPresented = true
                                UIPasteboard.general.setValue(colorExampleViewModel.drawHexNumber, forPasteboardType: "public.plain-text")
                            })
                    )
                
                HStack {
                    ColorPicker("", selection: $colorExampleViewModel.drawSwiftUIColor, supportsOpacity: true)
                        .padding()
                        .onChange(of: colorExampleViewModel.drawSwiftUIColor) { newValue in
                            colorExampleViewModel.getColorsFromPicker(pickerColor: newValue)
                        }
                        
                    
                    Text(colorExampleViewModel.drawHexNumber)
                        .bold()
                }
            }
            .alert(isPresented: $isPresented, content: {
                Alert(title: Text("The color value has been copied"))
            })
        
                
        }
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(colorExampleViewModel: ColorExampleViewModel())
    }
}
