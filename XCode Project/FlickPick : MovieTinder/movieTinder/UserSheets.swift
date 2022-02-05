//
//  UserSheets.swift
//  movieTinder
//
//  Created by Colby Beach on 9/17/21.
//


import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth


private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid



struct UserSheetView : View {
    
    @ObservedObject var user = UserViewModel()

    
    var profilePicture = "defaultUser"
    var userName = "defaultUser"
    var moviesLiked = [""]
    
    @State private var buttonText = "Add Friend"
    
    
    var body: some View{
        
        VStack{
            
            let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: profilePicUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                    } else {
                        Rectangle()
                            .fill(Color("lightgray"))
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                        }
                    }
                    .overlay(Circle()
                                .stroke(lineWidth: 9)
                                .opacity(0.3)
                                .foregroundColor(Color.red))
                    .padding(.top, 40)
                }

                    
            
            Text(userName)
                .font(.system(size: 25, weight: .medium, design: .default))
                .textCase(.lowercase)
                .padding()
                        
            Text(UserFunctions.getBio(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                .font(.system(size: 15, weight: .light, design: .default))
            
            Spacer()
             
            Button(action: {
                
                //This is a really bad way to fix a pretty bad bug in my code
                UserFunctions.addUserToFriends(index: 0, userName: "handler")
                //
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    UserFunctions.addUserToFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: userName)
                }
    
                buttonText = "Added!"
                
                
            }, label: {
                Text(buttonText)
                    .frame(width: 400, height: 50)
            })
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
        }
        .onAppear(){
            self.user.fetchData()
        }
        .background(Image("whitePinkGradient"))

       
        
    }
}

struct FriendSheetView : View {
    
    @ObservedObject private var user = UserViewModel()
    @StateObject private var movieListViewModel = MovieListViewModel()
    var movieModelFunctions = MovieModelFunctions()

    
    @Binding var userName : String
    @Binding var matchList : Array<String>
    
    @State private var buttonText = "Remove Friend"
    @State private var showingMovieDetail = false
    
    @State var currentMovie = Movie(adult: false, backdropPath: "", belongsToCollection: BelongsToCollection(id: 2, name: "", posterPath: "", backdropPath: ""), budget: 0, genres: [Genre(id: 0, name: "")], homepage: "", id: -1, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", productionCompanies: [ProductionCompany(id: 0, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountry(iso3166_1: "", name: "")], releaseDate: "", revenue: 2, runtime: 1, spokenLanguages: [SpokenLanguage(englishName: "", iso639_1: "", name: "")], status: "", tagline: "", title: "", video: false, voteAverage: 2.0, voteCount: 0)
    
    
    
    var body: some View{
        
        var movieMatchFetchList = movieListViewModel.returnList
        
        VStack{
        
            VStack{
                
                ScrollView{
                    
                    let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                    
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: profilePicUrl) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .scaledToFit()
                                    .cornerRadius(150)
                            } else {
                                Rectangle()
                                    .fill(Color("lightgray"))
                                    .frame(width: 200, height: 200)
                                    .scaledToFit()
                                    .cornerRadius(150)
                                }
                            }
                            .overlay(Circle()
                                        .stroke(lineWidth: 9)
                                        .opacity(0.3)
                                        .foregroundColor(Color.red))
                            .padding(.top, 30)
                        }

                    
                    Text(userName)
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .textCase(.lowercase)
                        .padding()
                      
                    Text(UserFunctions.getBio(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                        .font(.system(size: 15, weight: .light, design: .default))
                    
                    
                    LabelledDivider(label: "")
                    

                    Text("MATCHES:")
                        .padding()
                        .font(.headline)
                    
                    
                    
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns){
                
                        ForEach(movieMatchFetchList, id: \.self) { movies in
        
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
                   
                        } //For Each
                    }//Lazy Grid

                }//Scroll View
            } //VStack 2
            
            
            
            HStack{
                Button(action: {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        
                        if(matchList.count > 0){
                            currentMovie = movieMatchFetchList[Int.random(in: 0...matchList.count-1)]
                        }

                        
                    }
                    if(matchList.count > 0){
                        showingMovieDetail.toggle()
                    }
                 
                    
                }, label: {
                    Text("Shuffle!")
                        .frame(width: 200, height: 50)
                })
                .padding()
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                
                
                Button(action: {
                    
                    buttonText = "Removed!"

                    //This is a really bad way to fix a pretty bad bug in my code
                    UserFunctions.addUserToFriends(index: 0, userName: "handler")
                    //
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){

                        UserFunctions.removeUserFromFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: userName)

                    }
                 
                    
                }, label: {
                    Text(buttonText)
                        .frame(width: 200, height: 50)
                })
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                
            }//Hstack 2
            .padding(.bottom, 10)
            
            
        }//Vstack1
            
                    
            .sheet(isPresented: $showingMovieDetail, content: {
                
                BindMovieDetailView(currentMovie: $currentMovie)
                
                
            })
            
            .onAppear(){
                self.user.fetchData()
                
                movieListViewModel.fetchMovieList(movies: matchList)
            }
        .background(Image("whitePinkGradient"))

                
            
        }
    }

    struct FriendSheetViewAdd : View {
        
        @ObservedObject var user = UserViewModel()

        
        var profilePicture = "defaultUser"
        var userName = "defaultUser"
        var moviesLiked = [""]
        
        @State private var buttonText = "Already Your Friend!"
        
        
        var body: some View{
            
            VStack{
                
                let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: profilePicUrl) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)
                        } else {
                            Rectangle()
                                .fill(Color("lightgray"))
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)

                            }
                        }
                        .overlay(Circle()
                                    .stroke(lineWidth: 9)
                                    .opacity(0.3)
                                    .foregroundColor(Color.red))
                        .padding(.top, 40)

                    }

                        
                
                Text(userName)
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .textCase(.lowercase)
                    .padding()
                
                Text(UserFunctions.getBio(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                    .font(.system(size: 15, weight: .light, design: .default))
                
                Spacer()
                 
              
                Text(buttonText)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .onAppear(){
                self.user.fetchData()
            }
            .background(Image("whitePinkGradient"))

           
        }
        
}

struct SelfSheetView : View {
    
    @ObservedObject var user = UserViewModel()

    var userName = "defaultUser"
    
    
    var body: some View{
        
        VStack{
            
            let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(uid: Auth.auth().currentUser?.uid ?? "")))
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: profilePicUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)

                    } else {
                        Rectangle()
                            .fill(Color("lightgray"))
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                        }
                    }
                    .overlay(Circle()
                                .stroke(lineWidth: 9)
                                .opacity(0.3)
                                .foregroundColor(Color.red))
                    .padding(.top, 40)

                }

                    
            
            Text(userName)
                .font(.system(size: 25, weight: .medium, design: .default))
                .textCase(.lowercase)
                .padding()
            
            Text(UserFunctions.getBio(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                .font(.system(size: 15, weight: .light, design: .default))
            
            Spacer()
             
            Text("This is your public profile!")
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color.purple)
                .cornerRadius(15.0)
        }
        .onAppear(){
            self.user.fetchData()
        }
        .background(Image("whitePinkGradient"))

       
        
    }
}


