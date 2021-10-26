//
//  ContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

private var db = Firestore.firestore()
private var userStore = UserStoreFunctions()
private let amtOfMovies = 1968




/**
 
 Movie View is the View that is first shown when opening the app.
 
 Has a first function to get the current movie needed.
 
 Shows movie picture, title, description, and other related data.
 
 Users are then able to like and dislike the movie, which the app will then
    move on to the next movie after a decision is made
 
 Paramaters: None
 Return: View Model
 
 **/

struct MovieView: View {
    
        
    @ObservedObject var movieList = MovieViewModel()
    @State var updater = ""
    
    @State var showingMoviePoster = false
    @State var moviePoster = ""
    @State var randomNum = Int.random(in: 0..<amtOfMovies)

    
    
    /**
     Function that will retrieve movie data for a new movie to be displayed.
     
     Param: Takes a random integer (based off of how many movies the user has avaiable)
     
     If the random integer has not already been liked or disliked by the current user it will be shown
        if it has been then it will add numbers to the random num until it finds a movie that hasn't
        If this reaches the end of the movie count, it will go back to the beginning.
     */
    func getCurrentMovie(randomNum : Int) -> Dictionary<String, String>{
                

        let likedList = userStore.getLikedList(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
        let dislikedList = userStore.getDislikedList(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
        
        var title = ""
        var desc = ""
        var poster = "https://i.ibb.co/yRrfLwf/Flick-Pick-logos-transparent.png"
        var rating = ""
        var year = ""
        
        //Handles beginning exception
        if movieList.movies.count > 0 {
            
            var x = randomNum;
            
            while x < movieList.movies.count {
                                
                if(!likedList.contains(movieList.movies[x].Title)){
                    
                    if(!dislikedList.contains(movieList.movies[x].Title)){
                        title = movieList.movies[x].Title
                        desc = movieList.movies[x].Plot
                        poster = movieList.movies[x].Poster
                        rating = movieList.movies[x].imdbRating
                        year = "(" + movieList.movies[x].Year! + ")"
                        
                        break;
                    }
                }
                
                x += 1
                
                if(x >= movieList.movies.count){
                    
                    for movies in movieList.movies {
                        
                        if(!likedList.contains(movies.Title)){
                            
                            if(!dislikedList.contains(movies.Title)){
                                title = movies.Title
                                desc = movies.Plot
                                poster = movies.Poster
                                rating = movies.imdbRating
                                year = "(" + movies.Year! + ")"
                                
                                break;
                            }
                        }
                        else{
                            title = "No More Movies Left!!"
                            desc = "Check Back Later!"
                        }
                        
                    }//For Loop
                } //if statement
                
            }  //while loop
        } //Original exception if statement
        

        
        let dict = ["title": title, "desc": desc, "rating": rating, "year": year, "poster": poster]
        
        return dict
        
        
    } //Function End
    
    
    
    var body: some View {
        
        var currentMovie = getCurrentMovie(randomNum: randomNum)
    
        
        ZStack{
            
                VStack{
                    
                    Button {
                        
                        moviePoster = currentMovie["poster"] ?? ""
                        showingMoviePoster.toggle()
                        
                        
                    } label: {
                        let url = URL(string: currentMovie["poster"] ?? "")
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

                   
                    ScrollView{

                        VStack{
                            
                            
                            HStack{
                                
                                HStack{
  
                                    
                                    Text(currentMovie["title"] ?? "")
                                        
                                        .font(.system(size: 30).bold())
                                        
                                        .foregroundColor(.pink)
                                      

                                    
                                        
                                    Text(currentMovie["year"] ?? "")
                                        .font(.system(size: 17).bold())
                                        .foregroundColor(.secondary)
                                    
                                    Text(updater)

                                                            
                                }
                                .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 100)
                            
                            
                            HStack{
                                
                                Text("IMDB Rating: ")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Text(currentMovie["rating"] ?? "" + "/10")
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
                            
                            Text(currentMovie["desc"] ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 130)

                            
                        }   //Vstack For text
                    
                    Spacer()    //Pushes Descp/Pic up

                } //Scroll View
                    
            }//VStack for Pics/Text
           
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    ZStack{
                        
                        Button(action: {
                        }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 70))
                                    .padding(.horizontal, 50)
                                    .padding(.bottom, 20)
                                    .shadow(color: .blue, radius: 5, x: 0, y: 3)


                                }
                        
                        //Main Button Pressed
                        Button(action: {
                            
                            userStore.addToMoviesDisliked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: currentMovie["title"]!)
                            

                                randomNum = Int.random(in: 0..<amtOfMovies)
                                currentMovie = getCurrentMovie(randomNum: randomNum)
                                updater =  ""
                                updater =  " "
                            


                        }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 70))
                                    .padding(.horizontal, 50)
                                    .padding(.bottom, 20)
                                    
                                }
             
                    }   //ZStack
                    
                    
                    ZStack{
                        
                        Button(action: {}) {
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 70))
                                    .padding(.horizontal, 50)
                                    .padding(.bottom, 20)
                                    .shadow(color: .pink, radius: 5, x: 0, y: 3)

                                    
                                }
                        
                        //Main Button Pressed
                        Button(action: {
                            
                            userStore.addToMoviesLiked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: currentMovie["title"]!)
                            
                            
                            randomNum = Int.random(in: 0..<amtOfMovies)
                            currentMovie = getCurrentMovie(randomNum: randomNum)
                            updater =  ""
                            updater =  " "

                                

                        }) {
                                Image(systemName: "heart.circle.fill")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 70))
                                    .padding(.horizontal, 50)
                                    .padding(.bottom, 20)


                                }
                    }//ZStack
                    
                    
                }//Hs stack
            
            }//VStack for like buttons

        } //ZStack
        
        
        .background(Image("whitePinkGradient"))
        
        .onAppear() {
            self.movieList.fetchData()
          
        }
        
        
    } //Var body : some View
} //Struct



//
//struct MovieView_Preview: PreviewProvider  {
//
//    static var previews: some View {
//
//        MovieView()
//
//    }
//}

