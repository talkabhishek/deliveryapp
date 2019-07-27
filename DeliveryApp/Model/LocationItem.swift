//
//  Location+CoreDataClass.swift
//  
//
//  Created by abhisheksingh03 on 26/07/19.
//
//

import Foundation
import CoreData

class LocationItem: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case address
    }

    // MARK: - Core Data Managed Object
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var address: String?

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
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        self.lng = try container.decodeIfPresent(Double.self, forKey: .lng) ?? 0
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
        try container.encode(address, forKey: .address)
    }
}
