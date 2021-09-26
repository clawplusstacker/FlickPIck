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
import FirebaseAuth
import Firebase



struct LoginContentView: View {
    
    @State var signInSuccess = false
    @State var homeScreenWanted = true
    @State var fireSignedIn = Auth.auth().currentUser

    @ViewBuilder
    
    var body: some View {
        
        if (signInSuccess || fireSignedIn != nil) {
            
            MainContentView(loggedIn: $signInSuccess)
                .onAppear(){
                    signInSuccess = true
                    fireSignedIn = nil
                }
            
        }else if(homeScreenWanted){
            
            HomeScreenView(signInSuccess: $signInSuccess)
            
        }
     
    }   //View
}   //Struct




struct HomeScreenView: View{
    
    
    @Binding var signInSuccess : Bool
        
    @State var showingSignIn = false
    @State var showingSignUp = false

    

    
    var body: some View {
        
        
        ZStack{
            
            //Background image
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
                
                Spacer()
                
                Button {
                    showingSignIn.toggle()

                } label: {
                    Text("Login")
                        .frame(width: 350, height: 20)
                }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)

                .sheet(isPresented: $showingSignIn){
                    
                    LoginFormView(signInSuccess: $signInSuccess)
                    
                }
                    
               
 
                
                Button {
                    showingSignUp.toggle()

                } label: {
                    Text("Sign Up")
                        .frame(width: 325, height: 20)
                }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.pink)
                    .cornerRadius(15.0)
                    
                .sheet(isPresented: $showingSignUp){
                    
                    SignUpView(signInSuccess: $signInSuccess)
                    
                }
                  
                
                
            } //VStack
        } //ZStack
    } //View
}   //Struct



struct LoginFormView: View{

    @Binding var signInSuccess : Bool
    
    @State var changePasswordView = false
    
    @State private var email = "";
    @State private var password = "";
    
    
    @State private var errorMessage = "";
    @State private var showingError = false;


    var body: some View {
        
        Spacer()
        
        ScrollView {
            
        ZStack {
                            
            VStack{
                
                Text("WE DON'T POST ANYTHING TO FACEBOOK")
                    .foregroundColor(Color.gray)
                    .padding(.top, 150)

                
                
                Button {

                } label: {
                    Text("Login With Facebook")
                        .frame(width: 325, height: 20)
                }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                
                
                LabelledDivider(label: "OR")
                    .padding()

                
                if(showingError){
                    Text(errorMessage)
                        .foregroundColor(Color.pink)
                        .padding()
                }
                
                
                
                TextField("Email:", text: $email)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 15)

                
                
                //SecureField makes the letters hidden
                SecureField("Password:", text: $password)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 15)
                
                
                Button{
                    
                    let checkFields = validateSignIn(email: email, password: password)
                    
                    if checkFields != nil {
                        
                        showingError = false
                        errorMessage = checkFields!
                        showingError = true
                        
                    }else{
                        
                        Auth.auth().signIn(withEmail: email, password: password) {
                            (result, error) in
                                
                            if error != nil{
                                showingError = false
                                errorMessage = "The email and/or password was did not match any existing user!"
                                showingError = true
                            } else{
                                signInSuccess = true;
                            }
                            
                        }   //Sign in Auth
                        
                    }  // Check Fields
                } label: {
                    Text("Login With Email")
                        .frame(width: 325, height: 20)
                }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.pink)
                    .cornerRadius(15.0)
                    .padding()
                
                Button("Forgot Password?"){
                    changePasswordView.toggle()
                }
                    .padding()
                    .foregroundColor(.blue)
                .sheet(isPresented: $changePasswordView) {
                    ChangePasswordView()
                }
                
            
            }   //VStack
        } //ZStack
        
        Spacer()
        
        HStack(){
            Text("By continuing, you agree to our Terms of Use & Privacy Policy")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
                .padding(.horizontal, 100)

        }   //HStack
    }//ScrollView
        .background(Image("whitePinkGradient"))

     
    }   //View
        
}   //Struct



struct SignUpView: View{
    
    @Binding var signInSuccess : Bool

    
    @State private var email = "";
    @State private var userName = "";
    @State private var password = "";
    @State private var passwordVerify = "";
    
    
    @State private var errorMessage = "";
    @State private var showingError = false;
    
    
    var body: some View{
        
        Spacer()
        
        ScrollView {
            
            VStack{
                
                
                Text("WE DON'T POST ANYTHING TO FACEBOOK")
                    .foregroundColor(Color.gray)
                    .padding(.top, 120)

                    
                Button(){
                   
            
                    
                }label: {
                    Text("Sign Up with Facebook")
                        .frame(width: 350, height: 50)
                }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .padding()
                
                
                LabelledDivider(label: "OR")
                    .padding()

                
                
                if(showingError){
                    Text(errorMessage)
                        .foregroundColor(Color.pink)
                        .padding()
                }
                
                
        
                TextField("Enter Email:", text: $email)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 12)
                
                TextField("Create Username:", text: $userName)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 12)
                
                //SecureField makes the letters hidden
                SecureField("Create Password:", text: $password)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 12)
                
                SecureField("Verify Password:", text: $passwordVerify)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 12)
                
                

                Button {
                    //Dismisses Keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    let checkFields = validateSignUp(email: email, userName: userName, password: password, passVerify: passwordVerify)
                    
                    if checkFields != nil {
                        
                        showingError = false
                        errorMessage = checkFields!
                        showingError = true

                    } else{
                        
                        Auth.auth().createUser(withEmail: email, password: password) { result, err in
                            
                            if err != nil {
            
                                showingError = false
                                errorMessage = "THERE WAS AN ERROR CREATING THE NEW USER!"
                                showingError = true

                            } else{
                                
                                let dataBase = Firestore.firestore()
                                dataBase.collection("users").addDocument(data: ["userName":  userName, "uid": result!.user.uid, "moviesLiked": [], "moviesDisliked": [], "friends": [] ]) { error in
                                    
                                    if  error != nil{
                                        showingError = false
                                        errorMessage = "ERROR SAVING USER DATA!"
                                        showingError = true
                                    }
                                } //Error adding user to firestore
                                
                                
                                //Successfully logged in
                                signInSuccess = true
                                
                                
                            }   //Error create user
                        }   //Create user
                    }   //if else check fields
                } label: {
                    Text("Sign Up With Email")
                        .frame(width: 350, height: 50)

                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                .padding()
                    
            }//End of VStack
        
            Spacer()
            
            HStack(){
                Text("By continuing, you agree to our Terms of Use & Privacy Policy")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14))
                    .padding(.horizontal, 100)
            }   //End of HStack
            
        } //End of ScrollView
        .background(Image("whitePinkGradient"))


        
    }//End of var: some body
}//End of view



///
///Check the login fields and validate that the data is correct
///If correct, the login returns nil, or returns error message in form of String
///
func validateSignUp(email: String, userName: String, password: String, passVerify: String) -> String? {
    
    
    //Checks that all fields are filled in
    if (email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        userName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passVerify.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
        
        return "PLEASE FILL IN ALL FIELDS"
        
    } else if (userName.contains(" ") || email.contains(" ") || password.contains(" ") || passVerify.contains(" ")){
        return "FIELDS CANNOT CONTAIN ANY SPACES!"
    } else if (password != passVerify){
        return "PASSWORDS DO NOT MATCH!"
    } else if isPasswordValid(password) == false{
        return "PASSWORDS NEED TO CONTAIN AT LEAST 8 CHARACTERS, ONE UPPERCASE LETTER, AND ONE NUMBER!"
    }
    
    return nil
    
}

func validateSignIn(email: String, password: String) -> String? {
    
    if (email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        password.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
        
        return "PLEASE FILL IN ALL FIELDS"
        
    } else if (email.contains(" ") || password.contains(" ")){
        return "FIELDS CANNOT CONTAIN ANY SPACES!"
    }
    
    return nil
    
}


///
///Password Valification Field Checker
///
func isPasswordValid(_ password : String) -> Bool{
    let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
    return passwordTest.evaluate(with: password)
}




