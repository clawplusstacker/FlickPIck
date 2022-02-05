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
    
    //Literally just for the navigation bar
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
    
    
    @State var userIndex = UserFunctions.getFireStoreUserIndex(uid: Auth.auth().currentUser?.uid ?? "")
    @StateObject var movieViewModel = MovieViewModel()
    @StateObject var popularViewModel = PopularViewModel()
    @StateObject var recViewModel = RecViewModel()

    @State var randomNum = Int.random(in: 0..<950000)
    
   
    func getCurrentMovie() -> Int{
        var likedList = UserFunctions.getLikedList(index: userIndex)
        let dislikedList = UserFunctions.getDislikedList(index: userIndex)
        

        let randomNum = Int.random(in: 0...5)
        
        if(randomNum == 1){
            likedList.reverse()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            popularViewModel.fetchPopList()
        }

        if(likedList.count != 0){
                                
            for id in likedList {
                
                DispatchQueue.main.async{
                    recViewModel.fetchRecList(movie_id: Int(id) ?? -1)
                }
                
                let recList = recViewModel.returnRecList.results

                for mov in recList{
                    if(!likedList.contains(String(mov.id)) && !dislikedList.contains(String(mov.id))){
                        return mov.id
                    }
                }
                
            } //Liked For Loop
        }//If statement
                
        
        var popList = popularViewModel.returnPopList.results;
        if(randomNum == 4){
            popList.reverse()
        }
        
        for mov in popList{
            if(!likedList.contains(String(mov.id)) && !dislikedList.contains(String(mov.id))){
                return mov.id
            }
        }
                
        //THIS IS HORRIBLE!
        return Int.random(in: 1..<950000)
        
    }
    

    @State var movie_id = 634649
    @State var updater = ""
    @State var showingMovieDetail = false
    
    var body: some View{
        
        var currentMovie = movieViewModel.returnMovie
        
        NavigationView {
        
        VStack{
            ZStack{
                
                Text(updater)
                
                let posterURL = URL(string: MovieFunctions.getMoviePosterURL(movie: currentMovie))
                                
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
                            ProgressView()
                            Text("Network Error")
                                .foregroundColor(.white)

                        } else {
                            ProgressView()
                        }
                    }
                }
                
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(currentMovie.title ?? "")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 30))
                            Text("(" + MovieFunctions.getMovieYear(movie: currentMovie) + ")")
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
                            MovieDetailView(currentMovie: currentMovie)
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
    
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    movie_id = getCurrentMovie()
                                    movieViewModel.fetchMovie(movie_id: movie_id)
                                    currentMovie = movieViewModel.returnMovie
                                    updater =  ""
                                    updater =  " "
                                }
                  
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


                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    movie_id = getCurrentMovie()
                                    movieViewModel.fetchMovie(movie_id: movie_id)
                                    currentMovie = movieViewModel.returnMovie
                                    updater =  ""
                                    updater =  " "
                                }
                   
    
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
            DispatchQueue.main.async{
                movie_id = getCurrentMovie()
                movieViewModel.fetchMovie(movie_id: movie_id)
                popularViewModel.fetchPopList()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                movie_id = getCurrentMovie()
                movieViewModel.fetchMovie(movie_id: movie_id)
                popularViewModel.fetchPopList()
            }
            
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
