//
//  Credits.swift
//  movieTinder
//
//  Created by Colby Beach on 2/2/22.
//

import Foundation

// MARK: - Credits
struct Credits: Hashable, Codable {
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Hashable, Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}



class CreditViewModel : ObservableObject {
    
    let urlFirst = "https://api.themoviedb.org/3/movie/"
    let urlLast = "/credits?api_key=63d93b08a5c17f9bbb9d8205524f892f"
    
    //Change to list of credits
    @Published var returnCredit : Credits = Credits(id: 0, cast: [])
    
    /**
        Fetches Credit List With Given Movie_ID
     */
    func fetchCredits(movie_id: Int){
        
        let urlMiddle = String(movie_id)
        let urlFull = urlFirst + urlMiddle + urlLast

        guard let urlFull = URL(string: urlFull) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlFull) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }

        
            do {
                let returnCredit = try JSONDecoder().decode(Credits.self, from: data)
                DispatchQueue.main.async {
                    self?.returnCredit = returnCredit
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    } // End of fetchMovie
}
