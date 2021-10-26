//
//  MoviePosterContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 10/12/21.
//

import Foundation
import SwiftUI

struct MoviePosterView: View{
    
    @Binding var moviePosterSend: String
    
    var body: some View{
        
        let url = URL(string: moviePosterSend)
        
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let moviePoster = UIImage(data: imageData)
                
                    
            Image(uiImage: moviePoster!)
                    .resizable()
                    .scaledToFit()
        } //Image URL
        
    }
}
