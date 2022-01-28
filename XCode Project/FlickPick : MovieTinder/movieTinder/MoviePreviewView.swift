//
//  MoviePreviewView.swift
//  movieTinder
//
//  Created by Colby Beach on 4/21/21.
//

import Foundation
import SwiftUI


/**
 MoviePreviewView is a view that will show a Movie poster, title, desc, etc
 when needed. This is different from MovieView as it has no like buttons, but
 everything else is similar. Used when looking at liked/disliked movies, or a users
 matches with another person.
 */

struct MoviePreviewView: View {
    
    //@ObservedObject var movieList = MovieViewModel()
    @Binding var movieTitle : String
    @State var handler = ""
    
    @State var showingMoviePoster = false
    @State var moviePoster = ""
    



    var body: some View {
        
        ZStack{
            
            ScrollView{

            
                VStack{
                    
                    Button {
                        moviePoster = ""
                        showingMoviePoster.toggle()
                        
                        
                    } label: {
                        let url = URL(string: "")
                        let data = try? Data(contentsOf: url!)

                        if let imageData = data {
                            let moviePoster = UIImage(data: imageData)
                                
                                    
                            Image(uiImage: moviePoster!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 600, height: 400)
                                .clipped()
                        } //Image URL
                    } //Button
                    
                    .sheet(isPresented: $showingMoviePoster) {
                        MoviePosterView(moviePosterSend: $moviePoster)
                    }
                    

                        VStack{
                
                            HStack{
                                
                                HStack{
  
                                    
                                    Text("Title")
                                        
                                        .font(.system(size: 23).bold())
                                        .foregroundColor(.pink)
        
                                        
                                    Text("()")
                                        .font(.system(size: 17).bold())
                                        .foregroundColor(.secondary)
                                    
                                    Text(handler)
                                    
                                                            
                                }
                                .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 100)
                            
                            
                            HStack{
                                
                                Image("imdb")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("IMDB Rating: " + "/10")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                              
                                
                                Spacer()

                            }
                            .padding()
                            .padding(.horizontal, 85)
                            
                            
                            Divider()
                                .padding()
                                                        
                            
                            HStack{
                                
                                Image(systemName: "text.bubble").foregroundColor(Color.black)
                                    .font(.system(size: 20))
                                
                                Text("Description:")
                                    .font(.headline)
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 85)
                            .padding()
                            
                            Text("Desc")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 130)
                            
                            
                            Text("\n \n \n \n \n \n \n")
                            
                        }   //Vstack For text
                    
                    Spacer()    //Pushes Descp/Pic up

                } //VStack for Pics/Text
            }   //Scroll View
           
                            
        } //ZStack
        .onAppear(){
            
            //self.movieList.fetchData()

        }
        .background(Image("whitePinkGradient"))
               
    }
}
