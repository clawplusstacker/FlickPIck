//
//  User.swift
//  movieTinder
//
//  Created by Colby Beach on 3/24/21.
//


import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

private var db = Firestore.firestore()

struct UserStore {
    
    var id: String
    var userName : String
    var uid : String
    var moviesLiked : Array<String>
    var moviesDisliked : Array<String>
    var friends : Array<String>
        
}

class UserStoreFunctions{
    
    private var users = UserViewModel()
    
    
    func getFirestoreUserID(uid: String) -> Int{

        self.users.fetchData()

        let numOfUsers = users.users.count
        var x = 0

        while x < numOfUsers {

            if users.users[x].uid == uid{
                return x
            }else{
                x += 1
            }
        }

        return x
    }
    

    func getMovieNum(index : Int) -> Int {
        
        if(self.users.users.count > 0){

            let currentUser = users.users[index]

            return currentUser.moviesDisliked.count + currentUser.moviesLiked.count
        }

        self.users.fetchData()


        return 0
        
    }
    
    func addToMoviesLiked(index: Int, title: String){
        
        let currentUserUID = users.users[index].id

        self.users.fetchData()


        let userDoc = db.collection("users").document(currentUserUID)

        userDoc.updateData([
            "moviesLiked": FieldValue.arrayUnion([title])
        ])
        
    }
    
    func addToMoviesDisliked(index: Int, title: String){
        
        
        let currentUserUID = users.users[index].id

        self.users.fetchData()

        
        let userDoc = db.collection("users").document(currentUserUID)
        
        userDoc.updateData([
            "moviesDisliked": FieldValue.arrayUnion([title])
        ])
        
    }
    
}
    
class UserViewModel:  ObservableObject{
    
    @Published var users = [UserStore]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("users").addSnapshotListener{ (QuerySnapshot, Error) in
            guard let documents = QuerySnapshot?.documents else{
                print("No Documents")
                return
            }
                        
            
            self.users = documents.map {  (QueryDocumentSnapshot) -> UserStore in
                
                let data = QueryDocumentSnapshot.data()
                
                let id = QueryDocumentSnapshot.documentID
                let userName = data["userName"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let moviesLiked = data["moviesLiked"] as? Array<String> ?? []
                let moviesDisliked = data["moviesDisliked"] as? Array<String> ?? []
                let friends = data["friends"] as? Array<String> ?? []
                
                return UserStore(id: id, userName: userName, uid: uid, moviesLiked: moviesLiked, moviesDisliked: moviesDisliked, friends: friends)
              
            }
        }

    }

}
