//
//  PINInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import Foundation
import KeychainAccess

protocol PresenterToInteractorPINProtocol: AnyObject {
    var headingTitle: String { get }
    var proceedButtonTitle: String { get }
    var textfieldPlaceholderTitle: String { get }
    var canSubmitPINNumber: Bool { get }
    var isPinNumberCorrect: Bool { get }
    var hasSetPINSecurityFactor: Bool { get }
    func setPINPassword()
    func updateInputPinWith(string: String)
    func resetKeychain()
}

final class PINInteractor: PresenterToInteractorPINProtocol {
    static let pinLenght = 4
    private static let staticUsername = "johnDoe"
    private var currentPassword: String = ""
    
    var headingTitle: String {
        return hasSetPINSecurityFactor ? "LoginHeading".localized() : "SecurityFactorHeading".localized()
    }
    
    var proceedButtonTitle: String {
        return hasSetPINSecurityFactor ? "LoginProceedButton".localized() : "LoginSavePINButton".localized()
    }

    var textfieldPlaceholderTitle: String {
        return hasSetPINSecurityFactor ?
        "LoginTextfieldProceedPlaceholder".localized() : "LoginTextfieldSecurityFactorPlaceholder".localized()
    }

    var canSubmitPINNumber: Bool {
        return currentPassword.count == PINInteractor.pinLenght
    }
    
    var isPinNumberCorrect: Bool {
        return currentPassword == getSavedPINPassword
    }
    
    var hasSetPINSecurityFactor: Bool {
        return getSavedPINPassword != nil
    }
    
    private var getSavedPINPassword: String? {
        let keychain = Keychain()
        return keychain[PINInteractor.staticUsername]
    }
    
    func setPINPassword() {
        let keychain = Keychain()
        keychain[PINInteractor.staticUsername] = currentPassword
    }
    
    func updateInputPinWith(string: String) {
        currentPassword = string
    }
    
    func resetKeychain() {
        do {
            try Keychain().removeAll()
        } catch let error {
            print("Keychain reset unssuccessful, error thrown: \(error)")
        }
    }
}
