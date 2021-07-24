//
//  AddMovies.swift
//
//
//  Created by Colby Beach on 5/11/21.
//

import Foundation
import RealmSwift
import SwiftUI


func CheckForMovies(){

    let realm = try! Realm();
    let movies = realm.objects(Movie.self);
    
    if(movies.count == 0){
        AddHBOMovies();
    }

}

func CreateMovie(Title: String, imdbRating : String, Plot : String, Poster: String, _id : String) -> Movie{
    
    let movie0 = Movie();
    
    movie0.Title = Title;
    movie0.imdbRating = imdbRating;
    movie0.Plot = Plot;
    movie0.Poster = Poster;
    movie0._id = _id;
    
    return movie0;

}

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}
func parse(jsonData: Data) -> MovieJSON? {
    do {
        let decodedData = try JSONDecoder().decode(MovieJSON.self, from: jsonData)
        return decodedData
    } catch {
        print("error decoding the file: \(error)")
    }
    return nil
}

func AddHBOMovies(){
    
    let jsonData = readLocalJSONFile(forName: "HBOfulldata")
    if let data = jsonData {
        if let movieList = parse(jsonData: data) {
            //print("movie list: \(movieList.Movie)")
            
            let realm = try! Realm();

            //Writing the movies to the realm
            try! realm.write{
                var id = 0; //Used to create a unique Id number for each number

                for movies in movieList.Movie{
                    
                    realm.add(CreateMovie(Title: movies.Title ?? "N/A", imdbRating: movies.imdbRating ?? "N/A", Plot: movies.Plot ?? "N/A", Poster: movies.Poster ?? "N/A", _id: String(id)))
                    
                    id+=1;
                }
            }
        }
    }
    
}


/**
    Function that adds test movies  to a realm- not actually on a specific streaming  service
 */
func AddTestMovies(){
    
    let realm = try! Realm();
    
    let movie0 = CreateMovie(Title: "The Wolf of Wall Street", imdbRating : "10", Plot: "Leo", Poster: "0", _id: "0");
    let movie1 = CreateMovie(Title: "The Dark Knight", imdbRating : "10", Plot: "Nanananananana", Poster: "1", _id: "1");
    let movie2 = CreateMovie(Title: "The Lord of the Rings", imdbRating : "10", Plot: "My Precious", Poster: "2",_id: "2");
    let movie3 = CreateMovie(Title: "365 Days", imdbRating : "3", Plot: "DisGUSTing", Poster: "3", _id: "3");
    let movie4 = CreateMovie(Title: "The Emporers New Groove", imdbRating : "7", Plot: "Forgotten Disney Movie", Poster: "4", _id: "4");

    
    
    try! realm.write{
        
        realm.add(movie0);
        realm.add(movie1);
        realm.add(movie2);
        realm.add(movie3);
        realm.add(movie4);
    }
    
}
