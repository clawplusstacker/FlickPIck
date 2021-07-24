//
//  movie.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//

import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var _id: String? = nil
    @objc dynamic var Actors: String? = nil
    @objc dynamic var Awards: String? = nil
    @objc dynamic var BoxOffice: String? = nil
    @objc dynamic var Country: String? = nil
    @objc dynamic var DVD: String? = nil
    @objc dynamic var Director: String? = nil
    @objc dynamic var Genre: String? = nil
    @objc dynamic var Language: String? = nil
    @objc dynamic var Metascore: String? = nil
    @objc dynamic var Plot: String = ""
    @objc dynamic var Poster: String = ""
    @objc dynamic var Production: String? = nil
    @objc dynamic var Rated: String? = nil
    @objc dynamic var Ratings: String? = nil
    @objc dynamic var Released: String? = nil
    @objc dynamic var Response: String? = nil
    @objc dynamic var Runtime: String? = nil
    @objc dynamic var Title: String = ""
    @objc dynamic var `Type`: String? = nil
    @objc dynamic var Website: String? = nil
    @objc dynamic var Writer: String? = nil
    @objc dynamic var Year: String? = nil
    @objc dynamic var imdbID: String? = nil
    @objc dynamic var imdbRating: String = ""
    @objc dynamic var imdbVotes: String? = nil
    override static func primaryKey() -> String? {
        return "_id"
    }

    
    func equals(movie1 : Movie) -> Bool{
        
        var result = false;
        
        if(movie1.Title == self.Title){
            result = true;
        }

        return result;
        
        
    }

    
}

struct MovieJSON: Decodable{
    
    var Movie : [Movies]

    
    struct Rating : Decodable{
        var Source : String? = nil;
        var Value : String? = nil;
    }
    struct Movies : Decodable{
        
        var Actors: String? = nil
        var Awards: String? = nil
        var BoxOffice: String? = nil
        var Country: String? = nil
        var DVD: String? = nil
        var Director: String? = nil
        var Genre: String? = nil
        var Language: String? = nil
        var Metascore: String? = nil
        var Plot: String? = nil
        var Poster: String? = nil
        var Production: String? = nil
        var Rated: String? = nil
        var Ratings : [Rating]? = nil
        var Released: String? = nil
        var Response: String? = nil
        var Runtime: String? = nil
        var Title: String? = nil
        var `Type`: String? = nil
        var Website: String? = nil
        var Writer: String? = nil
        var Year: String? = nil
        var imdbID: String? = nil
        var imdbRating: String? = nil
        var imdbVotes: String? = nil
    }
    
}

