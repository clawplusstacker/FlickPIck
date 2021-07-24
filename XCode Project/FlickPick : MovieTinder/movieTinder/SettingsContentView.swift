//
//  SettingsContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/30/21.
//

import Foundation
import RealmSwift
import SwiftUI


struct SettingsContentView : View{
    
    
    @State var settingsMainSelected = true;
    @State var changePassSelected = false;
    @State var notificationSelected = false;
    @State var streamingSelected = false;
    @State var loggingOut = false;


    var body: some View{
        
        return Group{
            
            if(settingsMainSelected){
                SettingsMainView(settingsMainSelected: $settingsMainSelected, changePassSelected: $changePassSelected, notificationSelected: $notificationSelected, streamingSelected: $streamingSelected, loggingOut: $loggingOut);
            }else if(changePassSelected){
                ChangePasswordView(backButton: $settingsMainSelected);
            }else if(notificationSelected){
                NotificationView(backButton: $settingsMainSelected);
            }else if(streamingSelected){
                StreamingServiceView(backButton: $settingsMainSelected);
            }else if(loggingOut){
                fatalError();
            }
            
        }//Return group
  
        
    }
}
struct SettingsMainView : View{
    
    @Binding var settingsMainSelected : Bool;
    @Binding var changePassSelected : Bool;
    @Binding var notificationSelected : Bool;
    @Binding var streamingSelected : Bool;
    @Binding var loggingOut : Bool;

    
    var body: some View{
        
                    
        VStack {
            
            HStack {
                
                Text("Settings")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                Spacer()
                    
            }
            
            .padding()
              
            HStack{
                
                Button("Change Password"){
                    settingsMainSelected = false;
                    changePassSelected = true;
                    notificationSelected = false;
                    streamingSelected = false;
            
                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 210, height: 100)
                .background(Color.yellow)
                .cornerRadius(15.0)
                    
                Button("Logout"){
                    
                    settingsMainSelected = false;
                    changePassSelected = false;
                    notificationSelected = false;
                    streamingSelected = false;
                    loggingOut = true;
                    
                    CurrentUser.loggedIn = false;
                    
        
                }
                    
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 190, height: 100)
                .background(Color.pink)
                .cornerRadius(15.0)
                
                
            }
            
            
            Spacer()

        }
    }
}

struct ChangePasswordView : View{
    
    @Binding var backButton : Bool
    
    @State private var password = "";
    @State private var passwordVerify = "";
    @State private var passVerifyFail = false;
    @State private var passChangeSuccess = false;
    @State private var passWhiteSpace = false;



    var body: some View{
        
        ZStack {
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        backButton = true;
                        
                                          
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                    
                    Spacer()

                
                    Text("Change Password")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                
                } //HSTACK
                .padding()
                
                if(passVerifyFail){
                    Text("Passwords do not match!")
                }
                if(passWhiteSpace){
                    Text("Passwords can not have any spaces!")
                }
                if(passChangeSuccess){
                    Text("Successfully Changed Your Password!")
                }
                
                SecureField("Enter New Password:", text: $password)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 8)
                             .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                     )
                    .shadow(radius:1)
                
                SecureField("Verify New Password:", text: $passwordVerify)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 8)
                             .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                     )
                    .shadow(radius:1)
                
                
                Button("Change Password"){
                    
            
                    if(password != passwordVerify){
                        passVerifyFail = true;
                        passWhiteSpace = false;
                        passChangeSuccess = false;

                    }else if(password.contains(" ")){
                    
                        passWhiteSpace = true;
                        passVerifyFail = false;
                        passChangeSuccess = false;


                    }else{
                        passChangeSuccess = true;
                        passWhiteSpace = false;
                        passVerifyFail = false;

                          
                        let realm = try! Realm();
                        try! realm.write{
                            CurrentUser.currentUser.password = password;
                        }
                            
                    }
                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
  
                
                Spacer()

            }
        }
    }
}
struct NotificationView : View{
    
    @Binding var backButton : Bool

    
    var body: some View{
        
        
        ZStack {
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        backButton = true;
                        
                                          
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                    
                    Spacer()

                
                    Text("Notification Settings")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                }
                .padding()
                
            }
        }
    }
}
struct StreamingServiceView : View{
    
    @Binding var backButton : Bool

    
    var body: some View{
    
        
        ZStack {
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        backButton = true;
                        
                                          
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                    
                    Spacer()

                
                    Text("Select Streaming Services")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                }
                .padding()
                
            }
        }
    }

}
