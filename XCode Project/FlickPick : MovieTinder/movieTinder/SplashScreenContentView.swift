//
//  SplashScreenContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 10/26/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct LoadingScreenContentView : View {
    
    @State var splashScreenShow = true
    @State var loginContentViewShow = false
    
    
    @State var testBool = false
    
    var body: some View {
        
        if(splashScreenShow == true){
            
            ZStack{
                MovieView()
                LikedContentView()
                FriendsView()
                SettingsMainView(loggingIn: $testBool)
                SplashScreenView(splashScreenShow: $splashScreenShow)
            }
          
      
        }else{
            LoginContentView()
        }
    }
}


struct SplashScreenView : View {
    
    @Binding var splashScreenShow : Bool
    
    @State private var isLoading = false
    @ObservedObject var movieList = MovieViewModel()

    
    var body: some View {
        
        
        ZStack{
            
            Image("moviecollage-1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
                Text("FlickPick")
                    .foregroundColor(.white)
                    .italic()
                    .font(.system(size: 70, weight: .black))
                    .padding(.top, 220)
                    .shadow(radius: 3)
                
                
                
                ZStack{
                    
                    Circle()
                        .stroke(Color(.systemGray5), lineWidth: 10)
                        .frame(width: 50, height: 50)
         
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color.pink, lineWidth: 7)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .onAppear() {
                            self.isLoading = true
                    }

                }   //Circle ZStack
                
                Spacer()

            } //VStack
        }   //ZStack
        
        .onAppear(){
            
            var timeToLoad = 3.0
            
            if(Auth.auth().currentUser == nil){
                timeToLoad = 0.5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + timeToLoad){
                splashScreenShow = false
            }
                
        }//On Appear
      
    }
}
