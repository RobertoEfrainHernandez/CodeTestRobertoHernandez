//
//  Address.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import RealmSwift

class Address: Object {
    @objc dynamic var address: String = ""
    var parentContact = LinkingObjects(fromType: Contact.self, property: "addresses")
}
