//
//  SettingsContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/30/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore



//Used for switch case for sheets
enum ActiveSheetSettings: Identifiable {
    case profilePic, changePass, stremServ, bio
    
    var id: Int {
        hashValue
    }
}



private var UserFunctions = UserStoreFunctions()

struct SettingsMainView : View{
    
    @ObservedObject private var user = UserViewModel()

        
    @Binding var loggingIn : Bool
    
    @State var userName = UserFunctions.getUsername(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
    
    @State var userIndex = UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? "")

    @State var showingSettingSheet: ActiveSheetSettings?
    
    var body: some View{
        
        NavigationView{
            
            VStack {

                Button {
                    showingSettingSheet = .profilePic
                    
                } label: {
                    
                    let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: userIndex))
                    
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: profilePicUrl) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 220, height: 220)
                                    .scaledToFit()
                                    .cornerRadius(150)
                            } else {
                                Rectangle()
                                    .fill(Color("lightgray"))
                                    .frame(width: 220, height: 220)
                                    .scaledToFit()
                                    .cornerRadius(150)
                                
                                } //else
                            }//async image
                            .overlay(Circle()
                                        .stroke(lineWidth: 9)
                                        .opacity(0.3)
                                        .foregroundColor(Color.red))
                        } //if available
                    } //Picture/Button
                        .padding(.vertical, 15)
                        .navigationBarHidden(true)
                        
                Text(userName)
                    .bold()
                    .font(.system(size: 25))
                
                Text(UserFunctions.getBio(index: userIndex))
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 3)
                
                LabelledDivider(label: "")

                       
                List{
                    
                    Section(header: Text("User Information")){
                        
                        HStack{
                            Text("Username: ")
                            Text(userName)
                                .foregroundColor(.pink)
                                .textCase(.lowercase)

                        }
                            .padding(5)
                        HStack{
                            Text("Email: ")
                            Text((Auth.auth().currentUser?.email ?? " "))
                                .foregroundColor(.pink)
                        }
                            .padding(5)
                        
                        Button {
                            showingSettingSheet = .bio
                        } label: {
                            HStack{
                                Text("Bio: ")
                                    .foregroundColor(.black)
                                Text(UserFunctions.getBio(index: userIndex))
                                    .lineLimit(1)
                                    .foregroundColor(.pink)
                            }
                        }
                            .padding(5)
                        
                        Button(action: {
                            showingSettingSheet = .changePass
                        }, label: {
                            Text("Change Password")
                                .foregroundColor(.black)


                        })
                            .padding(5)
                    }
                       
                   
                    Section(header: Text("Other")){
                        
                        Button(action: {
                            showingSettingSheet = .stremServ
                        }, label: {
                            Text("Streaming Services")
                                .foregroundColor(.black)
                        })
                            .padding(5)
                        
                        
                    } //Section
                  
                }.listStyle(InsetGroupedListStyle())
                    
                
                        
                HStack{
                    
                    Button{
                            
                        let firebaseAuth = Auth.auth()
                        do {
                          try firebaseAuth.signOut()
                        } catch let signOutError as NSError {
                          print("Error signing out: %@", signOutError)
                        }
                            loggingIn = false;
                                                
                
                    } label: {
                        Text("Logout")
                            .frame(width: 350, height: 50)
                    }
                            
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(Color.pink)
                    .cornerRadius(15.0)
                }
                .padding()
                
                
                .sheet(item: $showingSettingSheet) { item in
                    switch item {
                        case .profilePic:
                            AddProfilePicView()
                        case .stremServ:
                            StreamingServiceSettingsView()
                        case .changePass:
                            ChangePasswordView()
                        case .bio:
                            ChangeBioView()
                    }

                }
             
            } //Main VStack
        }//Navigation View
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("Settings")
                    .bold()
                    .foregroundColor(.pink)
                    .font(.system(size: 18))
            }
        }


        .onAppear(){
            
            self.user.fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                userName = UserFunctions.getUsername(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
            }
        }
    }
}

struct StreamingServiceSettingsView : View{
    
    @State private var trueToggle = true
    @State private var falseToggle = false

    var body: some View{
        
        VStack{
            
            HStack {
                
                Text("Streaming Services")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.pink)
                    .padding(.horizontal, 15)
                
                Spacer()
            
            } //HStack
            .padding(.top, 60)
            
            
            LabelledDivider(label: "")
                .padding()
            
            List{
                                    
                Toggle("HBO Max", isOn: $trueToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Netflix", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Disney Plus", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Hulu", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Prime Video", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Peacock", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                Toggle("Paramount Plus", isOn: $falseToggle)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .padding(5)
                    .disabled(true)
                
            }
            .padding()
            .foregroundColor(.gray)
     
            
        }
        
    }
}

struct ChangeBioView: View{
    
    @Environment(\.presentationMode) var presentationMode

    @State var userIndex = UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? "")
    
    @State var newBio = ""
    @State var errText = ""
    @State var totalChars = 0
    
    var body: some View{
        
        VStack{
            
            HStack {
        
                Text("Change Bio")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.pink)
                    .padding(.horizontal, 15)
                
                Spacer()
            
            } //HStack
            .padding(.top, 50)
            
            Text(errText)
                .foregroundColor(.pink)
                .padding(.top, 20)

            
            TextEditor(text: $newBio)
                .overlay(
                     RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.2)
                 )
                .frame(width: 350, height: 130)
                .padding(.top, 40)
                .onChange(of: newBio, perform: { text in
                    totalChars = text.count
                })
            
            ProgressView("\(totalChars) / 60", value: Double(totalChars), total: 60)
                .frame(width: 150)
                .padding()
                .accentColor(.pink)
                .onAppear(){
                }
                        
            Button {
           
                if(totalChars > 60){
                    errText = "Bio has to be less than 60 characters!"
                }else{
                    UserFunctions.addBio(index: userIndex, bio: newBio)
                    presentationMode.wrappedValue.dismiss()
                }


            } label: {
                Text("Change Bio")
                    .frame(width: 325, height: 20)
            }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                .padding(.top, 40)
            
            Spacer()
        }
        .onAppear(){
            newBio = UserFunctions.getBio(index: userIndex)
            totalChars = newBio.count
        }
        
    
    }
}
