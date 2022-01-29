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
    var body: some View{
        
        VStack{
            
            ZStack{
                
                let url = URL(string: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
                                
                let fade = Gradient(stops: [.init(color: .clear, location: 0),
                                             .init(color: .black, location: 2)])
                
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
                
                
                
                Text("Spider-Man: No Way Home")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 30))
                    .frame(width: 200)
                
                
            }
            .frame(width: 400, height: 700)
            .cornerRadius(30)
        }
    }
}


//struct MovieView: View {
//
//
//    @State var updater = ""
//    @State var moviePoster = ""
//
//
//
//    var body: some View {
//
//
//
//        ZStack{
//
//                VStack{
//
//                    Button {
//
//                        updater = ""
//
//
//
//                    } label: {
//                        let url = URL(string: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
//
//
//                        if #available(iOS 15.0, *) {
//                            AsyncImage(url: url) { phase in
//                                if let image = phase.image {
//                                    image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 600, height: 400)
//                                        .clipped()
//
//                                } else if phase.error != nil {
//                                    Text("Network Error!")
//                                        .frame(width: 600, height: 400)
//
//                                } else {
//                                    ProgressView()
//                                        .frame(width: 600, height: 400)
//                                }
//                            }
//                        } else {
//
//                        } //If statement for iOS 15
//                    } //Button
//
//
//                    ScrollView{
//
//                        VStack{
//
//
//                            HStack{
//
//                                HStack{
//
//
//                                    Text("Title")
//                                        .font(.system(size: 30).bold())
//                                        .foregroundColor(.pink)
//
//
//                                    Text("Year")
//                                        .font(.system(size: 17).bold())
//                                        .foregroundColor(.secondary)
//
//                                    Text(updater)
//
//
//                                }
//                                .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))
//
//                                Spacer()
//
//                            }
//                            .padding(.horizontal, 100)
//
//
//                            HStack{
//
//                                Image("imdb")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//
//                                Text("IMDB Rating: " + "/10")
//                                    .font(.subheadline)
//                                    .foregroundColor(.primary)
//
//
//                                Spacer()
//
//                            }
//                            .padding()
//                            .padding(.horizontal, 85)
//
//
//                            Divider()
//                                .padding()
//
//
//                            HStack{
//
//                                Image(systemName: "text.bubble").foregroundColor(Color.black)
//                                    .font(.system(size: 20))
//
//                                Text("Description:")
//                                    .font(.headline)
//
//                                Spacer()
//
//                            }
//                            .padding(.horizontal, 85)
//                            .padding()
//
//                            Text("Desc")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                                .padding(.horizontal, 130)
//
//                            Text("\n \n \n \n \n \n \n")
//
//
//                        }   //Vstack For text
//
//                    Spacer()    //Pushes Descp/Pic up
//                } //Scroll View
//
//            }//VStack for Pics/Text
//
//
//            VStack{
//
//                Spacer()
//
//                HStack{
//
//                    ZStack{
//
//                        Button(action: {
//                        }) {
//                                Image(systemName: "xmark.circle")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 70))
//                                    .padding(.horizontal, 50)
//                                    .padding(.bottom, 20)
//                                    .shadow(color: .blue, radius: 5, x: 0, y: 3)
//                                }
//
//
//                        //Main Button Pressed
//                        Button(action: {
//
//                            userStore.addToMoviesDisliked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: "")
//
//                            //currentMovie = getCurrentMovie(randomNum: randomNum)
//                            updater =  ""
//                            updater =  " "
//
//
//
//                        }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                                    .font(.system(size: 70))
//                                    .padding(.horizontal, 50)
//                                    .padding(.bottom, 20)
//
//                                }
//
//                    }   //ZStack
//
//
//                    ZStack{
//
//                        Button(action: {}) {
//                                Image(systemName: "heart.circle")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 70))
//                                    .padding(.horizontal, 50)
//                                    .padding(.bottom, 20)
//                                    .shadow(color: .pink, radius: 5, x: 0, y: 3)
//                                }
//
//                        //Main Button Pressed
//                        Button(action: {
//
//                            userStore.addToMoviesLiked(index: userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), movie_id: "")
//
//
//                            //currentMovie = getCurrentMovie(randomNum: randomNum)
//                            updater =  ""
//                            updater =  " "
//
//                        }) {
//                                Image(systemName: "heart.circle.fill")
//                                    .foregroundColor(.pink)
//                                    .font(.system(size: 70))
//                                    .padding(.horizontal, 50)
//                                    .padding(.bottom, 20)
//
//
//                                }
//                    }//ZStack
//
//                }//Hs stack
//
//            }//VStack for like buttons
//
//        } //ZStack
//
//        .background(Image("whitePinkGradient"))
//
//        .onAppear() {
//            //self.movieList.fetchData()
//        }
//
//
//    } //Var body : some View
//} //Struct





struct MovieView_Preview: PreviewProvider  {

    static var previews: some View {

        MovieView()

    }
}
