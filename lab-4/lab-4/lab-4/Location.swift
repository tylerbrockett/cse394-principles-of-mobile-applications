//
//  Location.swift
//  lab-4
//
//  Created by Tyler Brockett on 2/16/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import Foundation


class Location {
    
    var name:String = ""
    var image:String = ""
    var description:String = ""
    
    init(name:String, image:String, description:String){
        self.name = name
        self.image = image
        self.description = description
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getImage() -> String {
        return self.image
    }
    
    func getDescription() -> String {
        return self.description
    }
    
}