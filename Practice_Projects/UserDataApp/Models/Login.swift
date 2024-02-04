//
//  Login.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 13/07/2023.
//

import Foundation
struct Login : Decodable{
    var results : [UserData]
}

struct UserData : Decodable{
    var name: FullName
    var email : String
    var login : UserDetails
    var phone : String
    var picture: Picture
}

struct UserDetails : Decodable{
    var username : String
    var password : String
}

struct Picture : Decodable{
    var large : String
}

struct FullName : Decodable{
    var title : String
    var first : String
    var last : String
}
