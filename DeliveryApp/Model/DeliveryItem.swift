//
//  DeliveryItem+CoreDataClass.swift
//  
//
//  Created by abhisheksingh03 on 26/07/19.
//
//

import Foundation
import CoreData

class DeliveryItem: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case desc = "description"
        case imageURL = "imageUrl"
        case location = "location"
    }

    // MARK: - Core Data Managed Object
    @NSManaged public var id: Int
    @NSManaged public var desc: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var location: LocationItem?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        let name = String(describing: type(of: self))
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext]
                as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: name, in: managedObjectContext) else {
                fatalError("Failed to decode")
        }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.location = try container.decodeIfPresent(LocationItem.self, forKey: .location)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(desc, forKey: .desc)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(location, forKey: .location)
    }
}
