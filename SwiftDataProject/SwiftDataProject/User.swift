//
//  User.swift
//  SwiftDataProject
//
//  Created by Iphigenie Bera on 6/26/24.
//
import Foundation
import SwiftData

@Model
class User{
    var name: String
    var city: String
    var joinDate: Date
    var jobs = [Job]()
    
    init(name: String, city:String, joinDate: Date){
        self.name=name
        self.city=city
        self.joinDate=joinDate
        self.jobs = jobs
    }
}

