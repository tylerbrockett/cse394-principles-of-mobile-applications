/*
 * @author Tyler Brockett
 * @project CSE 394 Lab 4
 * @version February 16, 2016
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Tyler Brockett
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


import Foundation

class Locations {
    
    var locations:[Location]
    
    init(){
        locations = [Location]()
        locations.append(Location(name:"Arizona", image:"arizona.jpg", description: "Arizona is a state in the southwestern region of the United States. It is also part of the Western United States and of the Mountain West states. It is the sixth largest and the 14th most populous of the 50 states. Its capital and largest city is Phoenix."))
        locations.append(Location(name:"Austria", image:"austria.jpg", description: "Austria is a federal republic and a landlocked country of over 8.66 million people in Central Europe. It is bordered by the Czech Republic and Germany to the north, Hungary and Slovakia to the east, Slovenia and Italy to the south, and Switzerland and Liechtenstein to the west."))
        locations.append(Location(name:"Belgium", image:"belgium.jpg", description: "Belgium is a sovereign state in Western Europe. It is a founding member of the European Union and hosts several of the EU's official seats and as well as the headquarters of many major international organizations such as NATO."))
        locations.append(Location(name:"California", image:"california.jpg", description: "California is a state located on the West Coast of the United States. It is the most populous U.S. state, with 39 million people, and the third largest state by area (after Alaska and Texas). California is bordered by Oregon to the north, Nevada to the east, Arizona to the southeast, and the Mexican state of Baja California to the south."))
        locations.append(Location(name:"Canada", image:"canada.jpg", description: "Canada  is a country in the northern part of North America. Its ten provinces and three territories extend from the Atlantic to the Pacific and northward into the Arctic Ocean, covering 9.98 million square kilometres (3.85 million square miles), making it the world's second-largest country by total area and the fourth-largest country by land area."))
        locations.append(Location(name:"Denmark", image:"denmark.jpg", description: "Denmark is a country in Northern Europe. The southernmost of the Nordic countries, it is southwest of Sweden and south of Norway, and bordered to the south by Germany. Denmark is part of Scandinavia, together with Sweden and Norway."))
        locations.append(Location(name:"England", image:"england.jpg", description: "England is a country that is part of the United Kingdom. It shares land borders with Scotland to the north and Wales to the west. The Irish Sea lies northwest of England and the Celtic Sea lies to the southwest. "))
        locations.append(Location(name:"France", image:"france.jpg", description: "France is a sovereign state comprising territory in western Europe and several overseas regions and territories. The European part of France, called metropolitan France, extends from the Mediterranean Sea to the English Channel and the North Sea, and from the Rhine to the Atlantic Ocean."))
        locations.append(Location(name:"Hawaii", image:"hawaii.jpg", description: "Hawaii is the 50th and most recent state of the United States of America, receiving statehood on August 21, 1959. Hawaii is the only U.S. state located in Oceania and the only one composed entirely of islands. It is the northernmost island group in Polynesia, occupying most of an archipelago in the central Pacific Ocean."))
        locations.append(Location(name:"Lichtenstein", image:"lichtenstein.jpg", description: "Lichtenstein is a doubly landlocked German-speaking microstate in Central Europe. It is a constitutional monarchy with the rank of principality, headed by the Prince of Liechtenstein."))
        locations.append(Location(name:"Luxemburg", image:"luxemburg.jpg", description: "Luxemburg is a landlocked country in western Europe. It is bordered by Belgium to the west and north, Germany to the east, and France to the south."))
        locations.append(Location(name:"Mexico", image:"mexico.jpg", description: "Mexico is a federal republic in North America. It is bordered on the north by the United States; on the south and west by the Pacific Ocean; on the southeast by Guatemala, Belize, and the Caribbean Sea; and on the east by the Gulf of Mexico."))
        locations.append(Location(name:"Netherlands", image:"netherlands.jpg", description: "Netherlands is a small, densely populated country located in Western Europe with three island territories in the Caribbean. The European part of the Netherlands borders Germany to the east, Belgium to the south, and the North Sea to the northwest, sharing maritime borders with Belgium, the United Kingdom and Germany."))
        locations.append(Location(name:"Scotland", image:"scotland.jpg", description: "Scotland is a country that is part of the United Kingdom and covers the northern third of the island of Great Britain. It shares a border with England to the south, and is otherwise surrounded by the Atlantic Ocean, with the North Sea to the east and the North Channel and Irish Sea to the south-west."))
        locations.append(Location(name:"Switzerland", image:"switzerland.jpg", description: "Switzerland is situated in Western and Central Europe, and is bordered by Italy to the south, France to the west, Germany to the north, and Austria and Liechtenstein to the east."))
        locations.append(Location(name:"Virginia", image:"virginia.jpg", description: "Virginia is a state located in the South Atlantic region of the United States. Virginia is nicknamed the \"Old Dominion\" due to its status as the first colonial possession established in mainland British America, and \"Mother of Presidents\" because eight U.S. presidents were born there, more than any other state"))
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