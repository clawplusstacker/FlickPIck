//
//  MoviePreviewView.swift
//  movieTinder
//
//  Created by Colby Beach on 4/21/21.
//

import Foundation
import SwiftUI

private var MovieFunctions = MovieModelFunctions()

struct MovieDetailView: View {
    
    @State var currentMovie : Movie
    @State var rating : Float = 8.4

    var body: some View {
        
        let urlBack = URL(string: MovieFunctions.getMovieBannerURL(movie: currentMovie))
        let url = URL(string: MovieFunctions.getMoviePosterURL(movie: currentMovie))
        

        let url2 = URL(string: "https://media.macosicons.com/parse/files/macOSicons/a84013184cc80749ff6eacbcda5c55fd_low_res_HBO_Max.png")
        
        ScrollView {
        VStack{
            //Banner/Poster
            ZStack{
    
                let fade = Gradient(stops: [.init(color: .clear, location: 1),
                                            .init(color: .gray, location: 0)])
                
              
                if #available(iOS 15.0, *) {
                    AsyncImage(url: urlBack) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 600, height: 350)
                                .clipped()
                                .overlay(LinearGradient(gradient: fade, startPoint: .leading, endPoint: .trailing))

                        } else if phase.error != nil {
                            Text("Network Error!")

                        } else {
                            ProgressView()
                        }
                    }
                } //Banner Image
                
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400, height:250)
                                .offset(x: -120, y: 20)
                        } else if phase.error != nil {
                            Text("Network Error!")

                        } else {
                            ProgressView()
                        }
                    }
                } //Main Poster Image
                
            }//ZStack
            .frame(width: 600, height: 400)
            
            
            VStack {
                
                HStack{
                    Text(currentMovie.title ?? "")
                        .foregroundColor(.pink)
                        .font(.system(size: 27))
                        .bold()
                    Text("(" + MovieFunctions.getMovieYear(movie: currentMovie) + ")")
                }
                
                
                HStack{
                    
                    HStack{
                        ProgressCircle(progress: self.$rating)
                            .frame(width: 50, height: 50)
                        
                        Text("User Score")
                            .bold()
                    }
                    .padding(.horizontal, 40)
                    
            
                   Spacer()
                    
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: url2) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .shadow(radius: 20)
                                    .padding(.horizontal, 40)
                            }else{
                                ProgressView()
                            }
                        }
                    } //Banner Image
                        
                    
                }
                .frame(width: 450, height: 70)
                
                VStack{
                    Text(MovieFunctions.getMovieDetailSectionData(movie: currentMovie))
                    Text(MovieFunctions.getMovieGenres(movie: currentMovie))
                }
                .font(.system(size: 14))
                .frame(width: 450, height: 50)
                .background(Color("lightgray"))
                .padding()
                
                HStack{
                    Text(currentMovie.tagline ?? "")
                        .font(.system(size: 15))
                        .italic()
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)
             

                HStack{
                    Text("Overview")
                        .font(.system(size: 20))
                        .foregroundColor(.pink)
                        .bold()
                    Spacer()
                }.padding()
                
                
                Text(currentMovie.overview ?? "")
                    .font(.system(size: 16))
                    .padding(.horizontal)
                

                Divider()
                    .padding()

                Text("Top Billed Cast")
                    .bold()
                    .font(.system(size: 20))
                    .padding()
                
                HStack(alignment: .top){
                    
                    let actor1 = URL(string: "https://www.themoviedb.org/t/p/w138_and_h175_face/2qhIDp44cAqP2clOgt2afQI07X8.jpg")
                    let actor2 = URL(string: "https://www.themoviedb.org/t/p/w138_and_h175_face/jHWlWOasiqKS8JI40g9GDH5X6AL.jpg")
                    let actor3 = URL(string: "https://www.themoviedb.org/t/p/w138_and_h175_face/fBEucxECxGLKVHBznO0qHtCGiMO.jpg")
                    
                    
                    VStack{
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: actor1) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    ProgressView()
                                }
                            } //Async
                        } //If Image
                        
                        Text("Tom Holland")
                            .bold()
                            .font(.system(size: 14))
                    }
                    .frame(width: 100, height:150)
                    .shadow(radius: 20)
                    .padding()
                    
                 
                    VStack{
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: actor2) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    ProgressView()
                                }
                            } //Async
                        } //If Image
                        
                        Text("Zendaya")
                            .bold()
                            .font(.system(size: 14))
                    }
                    .frame(width: 100, height:150)
                    .shadow(radius: 20)
                    .padding()


                    VStack(alignment: .center){
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: actor3) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    ProgressView()
                                }
                            } //Async
                        } //If Image

                        
                        Text("Benedict Cumberbatch")
                            .bold()
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 100, height: 150)
                    .shadow(radius: 20)
                    .padding()
                    
                }
             
            } //VStack Text
            .frame(width: 400)
            
            Spacer()
            
        } //VStack Main

        }//Scroll View
        .background(Image("whitePinkGradient"))
        .onAppear(){
            //Has to be done because binding is stupid
            rating = Float(currentMovie.voteAverage ?? 0.0)
        }

    }
}

//struct MovieDetailView_Preview: PreviewProvider  {
//
//    static var previews: some View {
//
//        MovieDetailView()
//
//    }
//}
