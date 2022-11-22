//
//  Movie.swift
//  MoviDB
//
//  Created by Phinder 2022 on 16/11/22.
//

import Foundation

struct MovieDataResponse: Codable {
    
    var succes: Bool?
    var expires_at: String?
    var request_token: String?

}

struct LoginRequets: Codable {
    let username: String
    let password: String
    let request_token: String?
}

struct StatusCode: Codable {
let status_message: String?
let status_code: Int?
}

///Estructura principal de las respuestas
struct Response: Codable{
    let status_message: String?
    let status_code: Int?
}

struct ListMovies: Codable {
    
    var id: Int?
    var page: Int?
    var results: Results?
    var total_pages: Int?
    var total_results: Int?
    
}

struct Results: Codable {
    
    var description: String?
    var favorite_count:  Int?
    var id: Int?
    var item_count:Int?
    var iso_639_1: String?
    var list_type: String?
    var name: String?
    var poster_path: String?
    
    
    func getDate()->String{
        let horaOne = "\(iso_639_1?.convertIntoDateFormated(fromFormat: "yyyy-MM-dd HH:mm", toFormat: "dd MMM yyyy") ?? "")"
        
        if horaOne.contains(":"){
            return "\(horaOne) hrs"
        }else{
            return horaOne
        }
    }
}

extension String {
    func convertIntoDateFormated(fromFormat: String? = "yyyy-MM-dd'T'HH:mm:ss", toFormat: String) -> String? {
        
        let dateFormatter = DateFormatter()
        
        let lc = "es_MX"
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: self) else { return nil }
        let today = Calendar.current.isDateInToday(date)
        
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat =  (today) ? "HH:mm" : toFormat
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter.string(from: date).capitalized
    }
    
}
