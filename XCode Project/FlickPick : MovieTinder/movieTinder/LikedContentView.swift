//
//  LikedView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LikedContentView : View{
    
    @State var likedSelected = true;
    @State var disSelected = false;
    
    var body: some View{
        
        
        if(likedSelected){
            LikedView(likedSelected: $likedSelected, dislikedSelected: $disSelected);
        }else if(disSelected){
            DislikedView(likedSelected: $likedSelected, dislikedSelected: $disSelected);
        }
        
    }
}

private var UserFunctions = UserStoreFunctions()
private var movieModelFunctions = MovieModelFunctions()
private var db = Firestore.firestore()

struct LikedView: View {
    
    @ObservedObject private var user = UserViewModel()
    @StateObject private var movieListViewModel = MovieListViewModel()

    @State private var likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))

    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
        
    @State var currentMovie = Movie(adult: false, backdropPath: "", belongsToCollection: BelongsToCollection(id: 2, name: "", posterPath: "", backdropPath: ""), budget: 0, genres: [Genre(id: 0, name: "")], homepage: "", id: -1, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", productionCompanies: [ProductionCompany(id: 0, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountry(iso3166_1: "", name: "")], releaseDate: "", revenue: 2, runtime: 1, spokenLanguages: [SpokenLanguage(englishName: "", iso639_1: "", name: "")], status: "", tagline: "", title: "", video: false, voteAverage: 2.0, voteCount: 0)
    
    
    @State var showingMovieDetail = false;
    @State var movieLikedList : [Movie] = []

    

    var body: some View {
        
            VStack {
                             
                HStack {
                                 
                    Text("Liked Movies")
                        .padding()
                        .foregroundColor(.pink)
                        .font(.system(size: 20, weight: .medium, design: .default))

                        

                    Divider()
                        .padding()
                    
                    Button(action: {
                        likedSelected = false;
                        dislikedSelected = true;
                        
                    }, label: {
                        Text("Disliked Movies")
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium, design: .default))

                    })
       
                }   //Hstack
                .frame(height: 60)
                
                Divider()
                    .padding(.horizontal, 30)
                
               
                
                
                ScrollView {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns){
                
                        ForEach(movieLikedList, id: \.self) { movies in
                            
                            ZStack{
                                
                                                        
                                Button(action: {
                                    
                                    currentMovie = movies
    
                                    showingMovieDetail.toggle()
                              
                          
                                    
                                }, label: {
                                    let url = URL(string: movieModelFunctions.getMoviePosterURL(movie: movies))

                                    if #available(iOS 15.0, *) {
                                        AsyncImage(url: url) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)

                                                
                                            } else if phase.error != nil {
                                                Text("Network Error!")
                                                
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                        .frame(width: 175, height: 250)
                                        .cornerRadius(20)
                                        .shadow(radius: 10)
                                        .padding()
                                    } //If Statement
                                })
                                
                                
                                Button(action: {
                                    UserFunctions.removeFromLiked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movies.id!))
                                    UserFunctions.addToMoviesDisliked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movies.id!))
                                    
                                    var index = 0
                                    for mov in movieLikedList {
                                        if mov.id == movies.id{
                                            movieLikedList.remove(at: index)
                                            break
                                        }
                                        index+=1
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                                        

                                    }
                                    
                        
                                }, label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 42))
                                        .shadow(radius: 4)
                                })//Button
                                    .offset(x: 50, y: 130)
                                
                                
                            }//ZStack
                            .buttonStyle(BorderlessButtonStyle())
                            
                        } //For Each
                    }//Lazy Grid
                } //Scroll View
                
                Spacer()
                                        
            }   //VStack
        
            .navigationBarHidden(true)

     
            .sheet(isPresented: $showingMovieDetail){
                BindMovieDetailView(currentMovie: $currentMovie)

            }
            
            .onAppear(){
                
                UserViewModel().fetchData()

                DispatchQueue.main.async(){
                    likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                    
                    movieListViewModel.fetchMovieList(movies: likedList)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    movieLikedList = movieListViewModel.returnList
                }

            }
    }

}

struct DislikedView: View {
    
    @ObservedObject private var user = UserViewModel()
    @StateObject private var movieListViewModel = MovieListViewModel()

    @State private var dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))

    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
        
    @State var currentMovie = Movie(adult: false, backdropPath: "", belongsToCollection: BelongsToCollection(id: 2, name: "", posterPath: "", backdropPath: ""), budget: 0, genres: [Genre(id: 0, name: "")], homepage: "", id: -1, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", productionCompanies: [ProductionCompany(id: 0, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountry(iso3166_1: "", name: "")], releaseDate: "", revenue: 2, runtime: 1, spokenLanguages: [SpokenLanguage(englishName: "", iso639_1: "", name: "")], status: "", tagline: "", title: "", video: false, voteAverage: 2.0, voteCount: 0)
    
    
    @State var showingMovieDetail = false;
    @State var movieLikedList : [Movie] = []

    

    var body: some View {
        
            VStack {
                             
                HStack {
                                 
                    Button(action: {
                        likedSelected = true;
                        dislikedSelected = false;
                        
                    }, label: {
                        Text("Liked Movies")
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium, design: .default))

                    })

                        

                    Divider()
                        .padding()
           
                    Text("Disliked Movies")
                        .padding()
                        .foregroundColor(.pink)
                        .font(.system(size: 20, weight: .medium, design: .default))

       
                }   //Hstack
                .frame(height: 60)
                
                Divider()
                    .padding(.horizontal, 30)
                
               
                
                
                ScrollView {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns){
                
                        ForEach(movieLikedList, id: \.self) { movies in
                            
                            ZStack{
                                
                                                        
                                Button(action: {
                                    
                                    currentMovie = movies
    
                                    showingMovieDetail.toggle()
                              
                          
                                    
                                }, label: {
                                    let url = URL(string: movieModelFunctions.getMoviePosterURL(movie: movies))

                                    if #available(iOS 15.0, *) {
                                        AsyncImage(url: url) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)

                                                
                                            } else if phase.error != nil {
                                                Text("Network Error!")
                                                
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                        .frame(width: 175, height: 250)
                                        .cornerRadius(20)
                                        .shadow(radius: 10)
                                        .padding()
                                    } //If Statement
                                })
                                
                                
                                Button(action: {
                                    UserFunctions.removeFromDisliked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movies.id!))
                                    UserFunctions.addToMoviesLiked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movies.id!))
                                    
                                    var index = 0
                                    for mov in movieLikedList {
                                        if mov.id == movies.id{
                                            movieLikedList.remove(at: index)
                                            break
                                        }
                                        index+=1
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                                        

                                    }
                                    
                        
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.pink)
                                        .font(.system(size: 42))
                                        .shadow(radius: 4)
                                })//Button
                                    .offset(x: 50, y: 132)
                                
                                
                            }//ZStack
                            .buttonStyle(BorderlessButtonStyle())
                            
                        } //For Each
                    }//Lazy Grid
                } //Scroll View
                
                Spacer()
                                        
            }   //VStack
        
            .navigationBarHidden(true)

     
            .sheet(isPresented: $showingMovieDetail){
                BindMovieDetailView(currentMovie: $currentMovie)

            }
            
            .onAppear(){
                
                UserViewModel().fetchData()

                DispatchQueue.main.async(){
                    dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                    
                    movieListViewModel.fetchMovieList(movies: dislikedList)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    movieLikedList = movieListViewModel.returnList
                }

            }
    }

}
