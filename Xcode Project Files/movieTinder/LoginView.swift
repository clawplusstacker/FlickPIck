//
//  LoginView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/20/21.
//

//
//  ContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//

import SwiftUI
import RealmSwift


/**
    Invisble view that is running the loginform view until a username and password match
 */
struct LoginContentView: View {
    
    @State var signInSuccess = false
    @State var newUserWanted = false


    var body: some View {
        
        return Group {
            if (signInSuccess || CurrentUser.loggedIn) {
                MainContentView();
            }else if(newUserWanted){
                SignUpView(newUserSuccess: $signInSuccess)
            }
            else {
                LoginFormView(signInSuccess: $signInSuccess, newUserWanted: $newUserWanted)
            }
        }
    }
}




/**
    View function for Login forms
 */
struct LoginFormView: View{

    //State looks for changing variable
    
    @State private var userName = "";
    @State private var password = "";
    
    
    //Binding lets us share a value between two places
    @Binding var signInSuccess: Bool
    @Binding var newUserWanted: Bool;
    
    @State private var incorrectUser = false;


    var body: some View {
      
        VStack{

    
            Text("Login:")
            
            if(incorrectUser){
                Text("The username/password was incorrect!")
                    .foregroundColor(.red)
                    
            }
            
            
            TextField("Username:", text: $userName)
                .padding()
                .cornerRadius(20.0)
                .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                 )
                .shadow(radius:1)
            
            
            //SecureField makes the letters hidden
            SecureField("Password:", text: $password)
                .padding()
                .cornerRadius(20.0)
                .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                 )
                .shadow(radius:1)
            
            

            Button("Sign In"){
               
                CheckForMovies();

                let userInputted = User();
                userInputted.userName = userName;
                userInputted.password = password;
                
                if(checkUserName(user1: userInputted) && checkPassword(user1: userInputted)){
                    print(Realm.Configuration.defaultConfiguration.fileURL)
                    CurrentUser.loggedIn = true;
                    signInSuccess = true;
                    
                }else{
                    incorrectUser = true;
                }
                
            }
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
            
            
            Button("Sign Up"){
                
                CheckForMovies();
                
                newUserWanted = true;
                
            }
            
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 50)
            .background(Color.pink)
            .cornerRadius(15.0)
                
        }
     
    }
    
}

struct SignUpView: View{
    
    
    @State private var userName = "";
    @State private var password = "";
    @State private var passwordVerify = "";
    @State private var newUserFail = false;
    @State private var passVerifyFail = false;
    @State private var userOrPassWhiteSpace = false;
    @Binding var newUserSuccess : Bool;
    
    var body: some View{
        
        VStack{

    
            Text("Create New User:")
            
            if(newUserFail){
                Text("The username already exists!")
                    .foregroundColor(.red)
                    
            }
            if(passVerifyFail){
                Text("The passwords did not match!")
                    .foregroundColor(.red)
                    
            }
            if(userOrPassWhiteSpace){
                Text("Username/Password cannot contain any spaces!")
                    .foregroundColor(.red)
                    
            }

            
            
            
            TextField("Create Username:", text: $userName)
                .padding()
                .cornerRadius(20.0)
                .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                 )
                .shadow(radius:1)
            
            
            //SecureField makes the letters hidden
            SecureField("Create Password:", text: $password)
                .padding()
                .cornerRadius(20.0)
                .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                 )
                .shadow(radius:1)
            
            SecureField("Verify Password:", text: $passwordVerify)
                .padding()
                .cornerRadius(20.0)
                .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                 )
                .shadow(radius:1)
            
            

            Button("Sign Up"){
                
                let user0 = User();
                user0.userName = userName;
                user0.password = password;
                
                if(password != passwordVerify){
                    
                    passVerifyFail = true;
                    userOrPassWhiteSpace = false;
                    newUserFail = false;

                    
                }else if(userName.contains(" ") || password.contains(" ") || userName ==  "" || password == ""){
                    
                    userOrPassWhiteSpace = true;
                    newUserFail = false;
                    passVerifyFail = false;

                    
                }else if(checkUserName(user1: user0)){
                        
                    newUserFail = true;
                    userOrPassWhiteSpace = false;
                    passVerifyFail = false;

                }else{
                    newUserSuccess = true;
                    CurrentUser.currentUser = user0;

                    let realm = try! Realm();
                    try! realm.write{
                        realm.add(user0)
                    }
                        
                    
                        
                }
            }
          
    
            
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
                
        }//End of VStack
    }//End of var: some body
}//End of view

func checkUserName(user1: User) -> Bool{
    
    var result = false;
    
    let user = try! Realm().objects(User.self)
    
    for users in user{
        
        if(users.userName.lowercased() == user1.userName.lowercased()){
            result = true;
            CurrentUser.currentUser = users;
        }
        
    }
    return result;
}

func checkPassword(user1: User) -> Bool{
    
    var result = false;
    
    let user = try! Realm().objects(User.self)
    
    for users in user{
        
        if(users.password == user1.password){
            result = true;
        }
        
    }
    
    return result;
    
}




/*
struct View_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}*/



