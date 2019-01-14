//
//  Validators.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 1/8/19.
//  Copyright © 2019 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case phone
    case birthday
    case state
    case zip
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .phone: return PhoneValidator()
        case .birthday: return BirthdayValidator()
        case .state: return StateValidator()
        case .zip: return ZipValidator()
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("An Email was not entered") }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest.evaluate(with: value)
        
        do {
            if result == false {
               throw ValidationError("Please enter a valid Email")
            }
        } catch {
            throw ValidationError("Please enter a valid Email")
        }
        return value
    }
}

struct PhoneValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("A Phone Number was not entered") }
        guard value.count == 10 else { throw ValidationError("Phone Number must be 10 characters long") }
        
        return value
    }
}

struct BirthdayValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("A Birthday was not entered") }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            
            if dateFormatter.date(from: value) == nil {
                throw ValidationError("Please format Birthday as Ex. (August 25, 1990)")
            }
        } catch {
                throw ValidationError("Please format Birthday as Ex. (August 25, 1990)")
            }
            return value
        }
}

struct StateValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("A City was not entered")}
        let stateRex = "^(?-i:A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$"
        let stateTest = NSPredicate(format: "SELF MATCHES %@", stateRex)
        let result = stateTest.evaluate(with: value)
        
        do {
            if result == false {
                throw ValidationError("Please provide a valid State Ex. (CA)")
            }
        } catch {
            throw ValidationError("Please provide a valid State Ex. (CA)")
        }
        return value
    }
}

struct ZipValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("A Zipcode was not entered")}
        let zipRex = "(^(?!0{5})(\\d{5})(?!-?0{4})(|-\\d{4})?$)"
        let zipTest = NSPredicate(format: "SELF MATCHES %@", zipRex)
        let result = zipTest.evaluate(with: value)
        
        do {
            if result == false {
                throw ValidationError("Please provide a valid Zipcode Ex. (90210)")
            }
        } catch {
            throw ValidationError("Please provide a valid Zipcode Ex. (90210)")
        }
        return value
    }
}
