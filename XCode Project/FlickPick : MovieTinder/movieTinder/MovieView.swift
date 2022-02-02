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
private var UserFunctions = UserStoreFunctions()
private var MovieFunctions = MovieModelFunctions()



struct MovieView: View {
    
    @StateObject var movieViewModel = MovieViewModel()
    @State var randomNum = Int.random(in: 0..<950000)

    
    func getCurrentMovie(randomNum: Int) -> Movie?{
        
        movieViewModel.fetchMovie(movie_id: randomNum)
        return movieViewModel.returnMovie
        
     
//        if((movCur.popularity ?? -1) > 1 && MovieFunctions.compareMovieToUser(movie_id: randomNum)
//           && MovieFunctions.streamingServiceCheck(movie_id: randomNum)){
//
//            return movCur
//
//        }
//
//        if(randomNum >= 950000){
//            return nil
//        }
//
//        var newRandomNum = randomNum + 1
//        return getCurrentMovie(randomNum: newRandomNum)
        
    }
    
    @State var userIndex = UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? "")
    @State var movie_id = 634649

    
    init() {
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
      coloredAppearance.backgroundColor = .white
      coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
      
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().compactAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      
      UINavigationBar.appearance().tintColor = .white
    }
    
    @State var updater = ""
    @State var showingMovieDetail = false
    
    var body: some View{
        
        var currentMovie = getCurrentMovie(randomNum: randomNum)
        
        NavigationView {
        
        VStack{
            ZStack{
                
                Text(updater)
                
                let posterURL = URL(string: MovieFunctions.getMoviePosterURL(movie: currentMovie!))
                                
                let fade = Gradient(stops: [.init(color: .clear, location: 0),
                                            .init(color: .black, location: 1.3)])
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: posterURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .overlay(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                        } else if phase.error != nil {
                            Text("Network Error!")

                        } else {
                            ProgressView()
                        }
                    }
                }
                
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(currentMovie!.originalTitle ?? "")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 30))
                            Text("(" + (currentMovie!.releaseDate ?? "2022") + ")")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                        .frame(width: 200)
                        .padding(.horizontal, 50)
                        
                        Button {
                            showingMovieDetail.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .padding(.horizontal, 60)
                        } //Button
                        
                        .sheet(isPresented: $showingMovieDetail){
                            MovieDetailView(currentMovie: currentMovie!)
                        }
                      
                    } //HStack
                    .offset(y: 250)

                    HStack{
                        
                        ZStack{
    
                            Button(action: {
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 60))
                                    .shadow(color: .blue, radius: 5, x: 0, y: 3)
                                }

                            //Main Button Pressed
                            Button(action: {
    
                                UserFunctions.addToMoviesDisliked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movie_id))
    
                                randomNum = Int.random(in: 0..<950000)
                                currentMovie = getCurrentMovie(randomNum: randomNum)
                                updater =  ""
                                updater =  " "
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 60))
                                    
                            }
                        }   //ZStack (Dislike Buttons)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 20)
    
    
                        ZStack{
    
                            Button(action: {}) {
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 60))
                                        .shadow(color: .pink, radius: 5, x: 0, y: 3)
                                    }
    
                            //Main Button Pressed
                            Button(action: {
    
                                UserFunctions.addToMoviesLiked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: String(movie_id))
    
    
                                randomNum = Int.random(in: 0..<950000)
                                currentMovie = getCurrentMovie(randomNum: randomNum)
                                updater =  ""
                                updater =  " "
    
                            }) {
                                Image(systemName: "heart.circle.fill")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 60))
                            }//Button
                            
                        }//ZStack (Heart Buttons)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 20)
                        
                    } //HStack (Buttons)
                    .offset(x: 0, y: 250)
                }//VStack (With Text)
            } //ZStack
            .frame(width: 400, height: 700)
            .cornerRadius(30)
        } //VStack
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .principal){
                HStack{
                    Image(systemName: "film")
                        .foregroundColor(.pink)
                    Text("FlickPick")
                        .italic()
                        .bold()
                        .foregroundColor(.pink)
                        .font(.system(size: 18))
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading){
                let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: userIndex))
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: profilePicUrl) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 32, height: 32)
                                .scaledToFit()
                                .cornerRadius(150)
                        } else {
                            Rectangle()
                                .fill(Color("lightgray"))
                                .frame(width: 32, height: 32)
                                .scaledToFit()
                                .cornerRadius(150)
                            } //else
                        }//async image
                    } //if aviablae
                }//Tool Bar Item
            }//ToolBar
        }//Navigation view
        .background(Image("whitePinkGradient"))
        .onAppear{
            movie_id = 634649
            movieViewModel.fetchMovie(movie_id: movie_id)
        }
    } //Var body: some
} //Struct




//struct MovieView_Preview: PreviewProvider  {
//
//    static var previews: some View {
//
//        MovieView()
//
//    }
//}
