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
private var currentUserUID = Auth.auth().currentUser?.uid

private var userStore = UserStoreFunctions()


struct MovieView: View {
    
    @State var movieNum = userStore.getMovieNum(index: userStore.getFirestoreUserID(uid: currentUserUID!))
        
    @ObservedObject var movieList = MovieViewModel()
    
    
    
    func getCurrentMovie() -> Dictionary<String, String>{
        
        var title = ""
        var desc = ""
        var poster = "https://cdn.theatlantic.com/thumbor/X3e6dgwG1vDBxRUBA8AY6nwIDJQ=/0x102:1400x831/960x500/media/img/mt/2013/12/wallstreet/original.jpg"
        var rating = ""
        var year = ""
        
        //Handles beginning exception
        if movieList.movies.count > 0 {
            
            title = movieList.movies[movieNum].Title
            desc = movieList.movies[movieNum].Plot
            poster = movieList.movies[movieNum].Poster
            rating = movieList.movies[movieNum].imdbRating
            year = movieList.movies[movieNum].Year!
            
        }
        
        let dict = ["title": title, "desc": desc, "rating": rating, "year": year, "poster": poster]
        
        return dict
        

    }
    
    var body: some View {
        
        
        var currentMovie = getCurrentMovie()


        ZStack{
            
            ScrollView{

            
                VStack{
                    
                    let url = URL(string: currentMovie["poster"]!)
                    let data = try? Data(contentsOf: url!)

                    if let imageData = data {
                        let moviePoster = UIImage(data: imageData)
                            
                                
                        Image(uiImage: moviePoster!)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: 600, height: 400)
                                .clipped()
                    } //Image URL

                    

                        VStack{
                            
                            
                            HStack{
                                
                                HStack{
                                    
                                    Text(currentMovie["title"]!)
                                        
                                        .font(.system(size: 23).bold())
                                        .foregroundColor(.pink)
                                      

                                    
                                        
                                    Text(currentMovie["year"]!)
                                        .font(.system(size: 17).bold())
                                        .foregroundColor(.secondary)

                                                            
                                }
                                .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 100)
                            
                            
                            HStack{
                                
                                Text("IMDB Rating: " + currentMovie["rating"]! + "/10")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding()
                                    .padding(.horizontal, 90)
                            
                                Spacer()

                            }

                            
                            
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

                                }
                        
                        //Main Button Pressed
                        Button(action: {
              
                            userStore.addToMoviesDisliked(index: userStore.getFirestoreUserID(uid: currentUserUID!), title: currentMovie["title"]!)
                            movieNum = userStore.getMovieNum(index: userStore.getFirestoreUserID(uid: currentUserUID!))


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
                                    
                                }
                        
                        //Main Button Pressed
                        Button(action: {
                            movieNum = userStore.getMovieNum(index: userStore.getFirestoreUserID(uid: currentUserUID!))
                            userStore.addToMoviesLiked(index: userStore.getFirestoreUserID(uid: currentUserUID!), title: currentMovie["title"]!)
                     
                            print(movieNum)

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
        .onAppear() {
            self.movieList.fetchData()
            movieNum = userStore.getMovieNum(index: userStore.getFirestoreUserID(uid: currentUserUID!))

        }
       
    }
   
}





//
//struct MovieView_Preview: PreviewProvider  {
//
//    static var previews: some View {
//
//        MovieView()
//
//    }
//}

