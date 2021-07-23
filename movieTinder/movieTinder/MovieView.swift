//
//  ContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//

import SwiftUI
import RealmSwift


struct MovieView: View {
    
    @State var movieNum = CurrentUser.currentUser.moviesLiked.count + CurrentUser.currentUser.moviesDisliked.count;

    var body: some View {
        
        
        VStack{
            
           
            
            let currentUser = CurrentUser.currentUser;
            let realm = try! Realm();
            let movies = realm.objects(Movie.self);
            let moviesLeft = movies.count;
            
            if(moviesLeft > movieNum){
                
                let movie1 = movies[movieNum];
         
                
            
            let url = URL(string: movie1.Poster)
            let data = try? Data(contentsOf: url!)

            if let imageData = data {
                let moviePoster = UIImage(data: imageData)
            
            
                
                Image(uiImage: moviePoster!)
                    
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                    .clipped()
            
                } //Image URL


                VStack{
                    Text(movie1.Title)
                        .font(.headline)
                        .padding()
                        
                    
                    Text(movie1.Plot + "  Rated: " + movie1.imdbRating + "/10")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    

                }
                Spacer()    
                
                HStack{
                    
                    Button(action: {
                        
                        
                        let realm = try! Realm();
                        
                        
                        try! realm.write{
                            
                            currentUser.moviesDisliked.append(movie1);

                        }
                        
                        movieNum = CurrentUser.currentUser.moviesLiked.count + CurrentUser.currentUser.moviesDisliked.count;
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .frame(width: 100, height: 100)
                    
                        
                            }
                    
                    Button(action: {
                        
                        
                        let realm = try! Realm();
              
                        try! realm.write{
                            currentUser.moviesLiked.append(movie1);
                        }
              
                        movieNum = CurrentUser.currentUser.moviesLiked.count + CurrentUser.currentUser.moviesDisliked.count;
                                          
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .frame(width: 100, height: 100)

                            }
                    
         
                }//Hs stack
            } else{
                Text("Uh oh! There are no movies left for you to choose from :(")
            }
        
            

        }
     

        
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


