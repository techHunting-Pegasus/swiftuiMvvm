//
//  model.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation




struct Person: JsonDeserializer, Hashable, Decodable,Encodable {
    
    
    var name: String?
    var height: String?


    mutating func deserialize(values: Dictionary<String, Any>?) {
        name = values?["name"] as? String
        height = values?["height"] as? String
        
    }
}

struct Person2: JsonDeserializer, Hashable, Decodable,Encodable {
    var mass: String = ""
    var hair_color: String = ""
    var skin_color: String = ""
    
    mutating func deserialize(values: Dictionary<String, Any>?) {
        
        mass = values?["mass"] as? String ?? ""
        hair_color = values?["hair_color"] as? String ?? ""
        skin_color = values?["skin_color"] as? String ?? ""
    }
}


 

struct Appointment: JsonDeserializer, Hashable, Decodable {
    var eyeColor: String = ""
    var birthdate: String = ""
 

    mutating func deserialize(values: Dictionary<String, Any>?) {
        eyeColor = values?["eye_color"] as? String ?? ""
        birthdate = values?["birth_year"] as? String ?? ""
      
    }
}


struct postRes: JsonDeserializer, Hashable, Decodable {
    var id: Int = 1
   

    mutating func deserialize(values: Dictionary<String, Any>?) {
        id = values?["id"] as? Int ?? 1
       
    }
}

struct createuser: JsonDeserializer, Hashable, Decodable {
    init() { }
    var status: String?
    var message: String?
    var data = DataClass()
    mutating func deserialize(values: Dictionary<String, Any>?) {
        status = values?["status"] as? String
        message = values?["message"] as? String
        
        //MARK: if the response is direct dictionary
        if let detail = values?["data"] as? Dictionary<String, Any>{
     
            data.deserialize(values: detail)
        }
        //MARK: if the response isarray of dictionary
//        if let detail = values?["data"] as? Array<Dictionary<String, Any>>{
//            for d in detail{
//                var app = DataClass.init()
//                app.deserialize(values: d)
//                data.append(app)
//            }
//        }
        
    }
}

// MARK: - DataClass
struct DataClass: JsonDeserializer, Hashable, Decodable {
    
    var  name : String?
    var  salary : String?
    var age: String?
    var  id: Int?
    mutating func deserialize(values: Dictionary<String, Any>?) {
        name = values?["name"] as? String
        salary = values?["salary"] as? String
        age = values?["age"] as? String
        id = values?["id"] as? Int
    }
}



struct Country: Codable {
    let name: Name?
    let tld: [String]?
    let cca2: String?
    let ccn3: String?
    let cca3: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    let currencies: [String: Currency]?
    let idd: ID?
    let capital: [String]?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let translations: Translations?
    let latlng: [Double]?
    let landlocked: Bool?
    let area: Double?
    let demonyms: [String: Demonym]?
    let flag: String?
    let maps: [String: String]?
    let population: Int?
    let car: Car?
    let timezones: [String]?
    let continents: [String]?
    let flags: [String: String]?
    let coatOfArms: [String: String]?
    let startOfWeek: String?
    let capitalInfo: CapitalInfo?
//    let postalCode: PostalCode
}

struct Name: Codable {
    let common: String?
    let official: String?
    let nativeName: NativeName?
}

struct NativeName: Codable {
    let fra: NameTranslations?
}

struct NameTranslations: Codable {
    let official: String?
    let common: String?
}

struct Currency: Codable {
    let name: String?
    let symbol: String?
}

struct ID: Codable {
    let root: String?
    let suffixes: [String]?
}

struct Translations: Codable {
    // Add translation properties for other languages here
    let ara: NameTranslations?
    let bre: NameTranslations?
    let ces: NameTranslations?
    // ... (other languages)
}

struct Demonym: Codable {
    let f: String?
    let m: String?
}

struct Car: Codable {
    let signs: [String]?
    let side: String?
}

struct CapitalInfo: Codable {
    let latlng: [Double]?
}

