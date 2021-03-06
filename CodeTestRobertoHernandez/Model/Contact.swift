//
//  Contact.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var color: String = ""
    let emails = List<Email>()
    let phoneNums = List<Phone>()
    let addresses = List<Address>()
}
