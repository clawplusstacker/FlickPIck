//
//  MoviePreviewView.swift
//  movieTinder
//
//  Created by Colby Beach on 4/21/21.
//

import Foundation
import SwiftUI
import RealmSwift

struct MoviePreview: View {
    

    var body: some View {
        
        VStack{

            let movie1 = CurrentUser.matchMovieSelected;
            
            let url = URL(string: movie1.Poster);
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let moviePoster = UIImage(data: imageData)
            

            
                Image(uiImage : moviePoster!)
                    
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                    .clipped()
                
            }

                VStack{
                    Text(movie1.Title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding()
                        
                    
                    Text(movie1.Plot + "  Rated: " + String(movie1.imdbRating) + "/10")
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
