//
//  Phone.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import RealmSwift

class Phone: Object {
    @objc dynamic var phoneNumber: String = ""
    var parentContact = LinkingObjects(fromType: Contact.self, property: "phoneNums")
}
