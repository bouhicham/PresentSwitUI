//
//  Persons+CoreDataProperties.swift
//  Social_Project
//
//  Created by HICHAM BOUZYARSIT on 09/12/2020.
//
//

import Foundation
import CoreData


extension Persons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persons> {
        return NSFetchRequest<Persons>(entityName: "Persons")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var adress: String?
    @NSManaged public var city: String?
    @NSManaged public var phone: String?
    @NSManaged public var saved: Bool

}

extension Persons : Identifiable {

}
