//
//  MoviePreviewView.swift
//  movieTinder
//
//  Created by Colby Beach on 4/21/21.
//

import Foundation
import SwiftUI


struct MoviePreviewView: View {
    
    @ObservedObject var movieList = MovieViewModel()
    @Binding var movieTitle : String
    @State var handler = ""
    
    @State var showingMoviePoster = false
    @State var moviePoster = ""
    
    func getCurrentMovie() -> Dictionary<String, String> {
        
        
        var title = movieTitle
        var desc = ""
        var poster = "https://i.ibb.co/yRrfLwf/Flick-Pick-logos-transparent.png"
        var rating = ""
        var year = ""
        
        var x = 0
        
        var dict = ["title": title, "desc": desc, "rating": rating, "year": year, "poster": poster]

        
        //Handles beginning exception
        if movieTitle != "" {
                        
                while x < movieList.movies.count{
                                        
                    
                    if(movieList.movies[x].Title == movieTitle){
                                    
                        title = movieList.movies[x].Title
                        desc = movieList.movies[x].Plot
                        poster = movieList.movies[x].Poster
                        rating = movieList.movies[x].imdbRating
                        year = movieList.movies[x].Year!
                        
                        dict = ["title": title, "desc": desc, "rating": rating, "year": year, "poster": poster]
                        
                        break;
                        
        
                    }
                    x += 1;
                }
                            
        
        }
        
        return dict
        
        
    }


    
    var body: some View {
        
        var currentMovie = getCurrentMovie()

        ZStack{
            
            ScrollView{

            
                VStack{
                    
                    Button {
                        moviePoster = currentMovie["poster"]!
                        
                        print(moviePoster)

                        showingMoviePoster.toggle()
                        
                        
                    } label: {
                        let url = URL(string: currentMovie["poster"]!)
                        let data = try? Data(contentsOf: url!)

                        if let imageData = data {
                            let moviePoster = UIImage(data: imageData)
                                
                                    
                            Image(uiImage: moviePoster!)
                                    .resizable()
                                    .frame(width: 600, height: 400)
                                    .clipped()
                        } //Image URL
                    }
                    
                    .sheet(isPresented: $showingMoviePoster) {
                        MoviePosterView(moviePosterSend: $moviePoster)
                    }
                    

        

                        VStack{
                            
                            
                            HStack{
                                
                                HStack{
  
                                    
                                    Text(currentMovie["title"]!)
                                        
                                        .font(.system(size: 23).bold())
                                        .foregroundColor(.pink)
                                      

                                    
                                        
                                    Text("(" + currentMovie["year"]! + ")")
                                        .font(.system(size: 17).bold())
                                        .foregroundColor(.secondary)
                                    
                                    Text(handler)
                                    
                                                            
                                }
                                .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 100)
                            
                            
                            HStack{
                                
                                Text("IMDB Rating: ")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Text(currentMovie["rating"]! + "/10")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Spacer()

                            }
                            .padding()
                            .padding(.horizontal, 85)

                            
                            
                            Divider()
                                .padding()
                            
                            
                            
                            HStack{
                                
                                Text("Description:")
                                    .font(.headline)
                                    .padding()
                                    .padding(.horizontal, 90)
                                
                                Spacer()
                            }
                            
                            Text(currentMovie["desc"]!)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 130)

                            
                        }   //Vstack For text
                    
                    Spacer()    //Pushes Descp/Pic up

                } //VStack for Pics/Text
            }   //Scroll View
           
                            
        } //ZStack
        .onAppear(){
            self.movieList.fetchData()


        }
        .background(Image("whitePinkGradient"))

               
    }
}
