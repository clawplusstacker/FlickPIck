//
//  MoviePreviewView.swift
//  movieTinder
//
//  Created by Colby Beach on 4/21/21.
//

import Foundation
import SwiftUI

struct MoviePreview: View {
    

    var body: some View {
        
        VStack{

                Image("1")
                    
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                    .clipped()
                
            

                VStack{
                    Text("Title")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding()
                        
                    
                    Text("  Rated: " + "/10")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    

                } //Sub VSTACK

                Spacer()
            
                   
            
        } //Main VSTACK



        
        //Styalizing the actual view frame:
        .frame(width: 400, height: 700)
            .cornerRadius(10)
            .overlay(
                 RoundedRectangle(cornerRadius: 8)
                     .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 3)
             )
        .shadow(radius: 1)

    }
}
