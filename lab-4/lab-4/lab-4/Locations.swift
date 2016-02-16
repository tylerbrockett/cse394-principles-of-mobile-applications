//
//  Locations.swift
//  lab-4
//
//  Created by tkbrocke on 2/16/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import Foundation

class Locations {
    
    var locations:[Location]
    
    init(){
        locations = [Location]()
        locations.append(Location(name:"Arizona", image:"arizona.jpg", description: "Arizona Description"))
        locations.append(Location(name:"Austria", image:"austria.jpg", description: "Austria Description"))
        locations.append(Location(name:"Belgium", image:"belgium.jpg", description: "Belgium Description"))
        locations.append(Location(name:"California", image:"california.jpg", description: "California Description"))
        locations.append(Location(name:"Canada", image:"canada.jpg", description: "Canada Description"))
        locations.append(Location(name:"Denmark", image:"denmark.jpg", description: "Denmark Description"))
        locations.append(Location(name:"England", image:"england.jpg", description: "England Description"))
        locations.append(Location(name:"France", image:"france.jpg", description: "France Description"))
        locations.append(Location(name:"Hawaii", image:"hawaii.jpg", description: "Hawaii Description"))
        locations.append(Location(name:"Lichtenstein", image:"lichtenstein.jpg", description: "Lichtenstein Description"))
        locations.append(Location(name:"Luxemburg", image:"luxemburg.jpg", description: "Luxemburg Description"))
        locations.append(Location(name:"Mexico", image:"mexico.jpg", description: "Mexico Description"))
        locations.append(Location(name:"Netherlands", image:"netherlands.jpg", description: "Netherlands Description"))
        locations.append(Location(name:"Scotland", image:"scotland.jpg", description: "Scotland Description"))
        locations.append(Location(name:"Switzerland", image:"switzerland.jpg", description: "Switzerland Description"))
        locations.append(Location(name:"Virginia", image:"virginia.jpg", description: "Virginia Description"))
    }
    
    func add(location:Location){
        locations.append(location)
    }
    
    func sort(){
        locations.sortInPlace{(location1, location2) -> Bool in
            return location1.name.lowercaseString < location2.name.lowercaseString
        }
    }
    
    func remove(index:Int) {
        locations.removeAtIndex(index)
    }
    
    func get(index:Int) -> Location {
        return locations[index]
    }
    
    func getSize() -> Int {
        return locations.count
    }
    
}