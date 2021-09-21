//
//  MainContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/28/21.
//

import Foundation
import SwiftUI

struct MainContentView: View {
    
    @Binding var loggedIn : Bool
    @State var string1 = ""
    @State var array1 = [String]()

    
    
    @State var selectedTab = 0;


    var body: some View {
        
        TabView(selection: $selectedTab){
            
            MovieView()
                .tabItem {
                    VStack{
                        Image(systemName: "film")
                        //Text("Movies")
                    }
                }.tag(0)
            
            NavigationView{
                LikedContentView()
            }
                .tabItem {
                    VStack{
                        Image(systemName: "checkmark.circle")
                        //Text("Likes")
                    }
                }.tag(1)
            NavigationView{
                FriendsContentView(passingUserName: $string1, passingMatchList: $array1)

            }
                .tabItem {
                    VStack{
                        Image(systemName: "person.circle")
                        //Text("Friends")
                    }
                }.tag(2)
            
            NavigationView{
                SettingsContentView(logIn: $loggedIn)
            }
                .tabItem {
                    VStack{
                        Image(systemName: "gear")
                        //Text("Settings")
                    }
                }.tag(3)
        }

    }
}
