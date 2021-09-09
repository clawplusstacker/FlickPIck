//
//  movie.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//


import Foundation
import FirebaseFirestore

struct Movie {
    
    var Plot: String = ""
    var Poster: String = ""
    var Title: String = ""
    var Year: String? = nil
    var imdbRating: String = ""



    
    func equals(movie1 : Movie) -> Bool{

        var result = false;

        if(movie1.Title == self.Title){
            result = true;
        }

        return result;

    }
    
}

/*
 I wish I knew how this class actually worked
 */
class MovieViewModel:  ObservableObject{
    
    @Published var movies = [Movie]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("HBOMaxMovies").addSnapshotListener{ (QuerySnapshot, Error) in
            guard  let documents = QuerySnapshot?.documents else{
                print("No Documents")
                return
            }
                        
            
            self.movies = documents.map {  (QueryDocumentSnapshot) -> Movie in
                
                let data = QueryDocumentSnapshot.data()
                
                let title = data["Title"] as? String ?? ""
                let desc = data["Plot"] as? String ?? ""
                let rating = data["imdbRating"] as? String ?? ""
                let year = data["Year"] as? String ?? ""
                let poster = data["Poster"] as? String ?? ""
                
                return Movie(Plot: desc, Poster: poster, Title: title, Year: year, imdbRating: rating)

              
            } 
        }

    }

}



