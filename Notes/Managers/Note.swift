//
//  Note.swift
//  Notes + CoreData
//
//  Created by Dinara Alagozova on 07.02.2022.
//

import CoreData

@objc(Note)
class Note : NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var title: NSString!
    @NSManaged var content: NSString!
}
