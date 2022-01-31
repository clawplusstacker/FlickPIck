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



struct MovieView: View {
    
    init() {
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
      coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
      coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
      
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().compactAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      
      UINavigationBar.appearance().tintColor = .white
    }
    
    @State var updater = ""
    @State var showingMovieDetail = false
    
    var body: some View{
        
        NavigationView {
        
        VStack{
            ZStack{
                
                let url = URL(string: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
                                
                let fade = Gradient(stops: [.init(color: .clear, location: 0),
                                            .init(color: .black, location: 1.3)])
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: url) { phase in
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
                            Text("Spider-Man: No Way Home")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 30))
                            Text("(2021)")
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
                            MovieDetailView()
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
    
//                                userStore.addToMoviesDisliked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: "")
    
                                //currentMovie = getCurrentMovie(randomNum: randomNum)
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
    
//                                userStore.addToMoviesLiked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: "")
    
    
                                //currentMovie = getCurrentMovie(randomNum: randomNum)
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
        .navigationTitle("FlickPick")
        .navigationBarTitleDisplayMode(.inline)
        }//Navigation view
    } //Var body: some
} //Struct




struct MovieView_Preview: PreviewProvider  {

    static var previews: some View {

        MovieView()

    }
}
