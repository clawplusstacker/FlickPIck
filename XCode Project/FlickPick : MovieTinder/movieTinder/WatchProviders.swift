////
////  WatchProviders.swift
////  movieTinder
////
////  Created by Colby Beach on 2/2/22.
////
//
//import Foundation
//
//
//// MARK: - Main List
//struct WatchProvidersList: Hashable, Codable {
//    let id: Int?
//    let results: Countries?
//}
//
//// MARK: - Different Countries
//struct Countries: Hashable, Codable {
//    let gb, ar, at, au, be, br, ca, ch, cl,co,cz,de,dk,ec,ee,es,fi,
//        fr, gr, hu,id,ie,`in`, it, jp, kr, lt,lv,mx,my,nl,no,nz,
//        pe,ph,pl,pt,ro,ru,se,sg,th,tr,us,ve,za: Country?
//
//    enum CodingKeys: String, CodingKey {
//        case ar = "AR"
//        case at = "AT"
//        case au = "AU"
//        case be = "BE"
//        case br = "BR"
//        case ca = "CA"
//        case ch = "CH"
//        case cl = "CL"
//        case co = "CO"
//        case cz = "CZ"
//        case de = "DE"
//        case dk = "DK"
//        case ec = "EC"
//        case ee = "EE"
//        case es = "ES"
//        case fi = "FI"
//        case fr = "FR"
//        case gb = "GB"
//        case gr = "GR"
//        case hu = "HU"
//        case id = "ID"
//        case ie = "IE"
//        case `in` = "IN"
//        case it = "IT"
//        case jp = "JP"
//        case kr = "KR"
//        case lt = "LT"
//        case lv = "LV"
//        case mx = "MX"
//        case my = "MY"
//        case nl = "Nl"
//        case no = "NO"
//        case nz = "NZ"
//        case pe = "PE"
//        case ph = "PH"
//        case pl = "PL"
//        case pt = "PT"
//        case ro = "RO"
//        case ru = "RU"
//        case se = "SE"
//        case sg = "SG"
//        case th = "TH"
//        case tr = "TR"
//        case us = "US"
//        case ve = "VE"
//        case za = "ZA"
//    }
//}
//
//// MARK: - Specific Country Details
//struct Country: Hashable, Codable {
//    let link: String
//    let buy, flatrate, rent: [BuyFlatRent]?
//}
//
//// MARK: - BuyFlatRent
//struct BuyFlatRent: Hashable, Codable {
//    let displayPriority: Int?
//    let logoPath: String?
//    let providerID: Int?
//    let providerName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case displayPriority = "display_priority"
//        case logoPath = "logo_path"
//        case providerID = "provider_id"
//        case providerName = "provider_name"
//    }
//}
//
//
//class WatchProviderModel : ObservableObject {
//
//    let urlFront = "https://api.themoviedb.org/3/movie"
//    let urlBack = "watch/providers?api_key=63d93b08a5c17f9bbb9d8205524f892f"
//    //Change to list of credits
//    @Published var returnWatchList : WatchProvidersList = WatchProvidersList(id: 0, results: Countries(gb: Country(link: "", buy: [BuyFlatRent(displayPriority: 0, logoPath: "", providerID: 0, providerName: "")]) as! Decoder))
//
//    /**
//        Fetches Credit List With Given Movie_ID
//     */
//    func fetchPopList(movie_id: Int){
//
//        let urlMiddle = String(movie_id)
//
//        guard let urlFull = URL(string: urlFront + urlMiddle + urlBack) else{
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: urlFull) { [weak self] data, _, error in
//            guard let data = data, error == nil else{
//                return
//            }
//
//            do {
//                let returnWatchList = try JSONDecoder().decode(WatchProvidersList.self, from: data)
//                DispatchQueue.main.async {
//                    self?.returnWatchList = returnWatchList
//                }
//            }
//            catch{
//                print(error)
//            }
//        }
//        task.resume()
//
//    } // End of fetchMovie
//}
