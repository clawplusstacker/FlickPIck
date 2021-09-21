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


}

struct MovieStoreFunctions{
    
    private var MovieView = MovieViewModel()
    
    
    
    func getMovieData(title: String) -> Movie{
        
        self.MovieView.fetchData()

        var result = Movie(Plot: "Loading", Poster: "https://cdn.theatlantic.com/thumbor/X3e6dgwG1vDBxRUBA8AY6nwIDJQ=/0x102:1400x831/960x500/media/img/mt/2013/12/wallstreet/original.jpg", Title: "Loading", Year: "", imdbRating: "")
                
        var x = 0
             
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            while x < MovieView.movies.count{
                
                if(MovieView.movies[x].Title == title){
                                
                    result =  MovieView.movies[x]
                    print(result)
                    break;
    
                }
                x += 1;
            }
        }
            
        print(result)
        return result
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



