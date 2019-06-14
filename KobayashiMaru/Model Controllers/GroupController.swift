//
//  GroupController.swift
//  KobayashiMaru
//
//  Created by Dustin Koch on 6/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation


class GroupController {
    //MARK: - Singleton
    static let sharedInstance = GroupController()
    private init() {}
    
    //MARK: - Source of truth
    var masterPersonList: [String] = []
    var groups: [[String]] = []
    
    //MARK: - CRUD functions
    
    func addPerson(name: String) {
        let person = name
        masterPersonList.append(person)
        updateGroups()
        save(people: masterPersonList)
    }
    
    func shufflePeople() {
        let shuffled = masterPersonList.shuffled()
        masterPersonList = shuffled
        save(people: masterPersonList)
    }
    
    
    func deletePerson(name: String) {
        let person = name
        guard let index = masterPersonList.firstIndex(of: person) else { return }
        masterPersonList.remove(at: index)
        updateGroups()
        save(people: masterPersonList)
    }
    
    func updateGroups() {
        let array = masterPersonList
        var counter = 1
        var index = 0
        var masterarray: [[String]] = []
        var group: [String] = []
        
        while index <= (array.count - 1) {
            if counter <= 2{
                counter += 1
                group.append(array[index])
                index += 1
            } else {
                masterarray.append(group)
                counter = 1
                group = []
            }
        }
        masterarray.append(group)
        groups = masterarray
    }

}//END OF CLASS

//MARK: - Persistence helper functions
extension GroupController {
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "PeopleList.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    func save(people: [String]){
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(people)
            try data.write(to: fileURL())
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadPeople() -> [String]?{
        let jsonDecoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let people = try jsonDecoder.decode([String].self, from: data)
            return people
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}//END OF EXTENSION
