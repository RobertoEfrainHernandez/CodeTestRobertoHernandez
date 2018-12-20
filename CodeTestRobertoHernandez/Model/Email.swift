//
//  Email.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import RealmSwift

class Email: Object {
    @objc dynamic var email: String = ""
    var parentContact = LinkingObjects(fromType: Contact.self, property: "emails")
}
