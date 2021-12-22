//
//  PINViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol ViewToPresenterVPINProtocol: UITextFieldDelegate {
    var headingTitle: String { get }
    var proceedButtonTitle: String { get }
    var textfieldPlaceholderTitle: String { get }
    var hasSetPINSEcurityFactor: Bool { get }
    func onProceedAction()
    func onSkipSecurityFactorAction()
}

final class PINViewController: UIViewController {
    // MARK: Properties
    var interactor: PresenterToInteractorPINProtocol!
    var pinView: PresenterToViewPINProtocol!
    var router: PresenterToRouterProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = pinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinView.setupViewWith(securityFactorSet: interactor.hasSetPINSecurityFactor)
    }
}

// MARK: ViewToPresenterVPINProtocol
extension PINViewController: ViewToPresenterVPINProtocol {
    var headingTitle: String {
        return interactor.headingTitle
    }
    
    var proceedButtonTitle: String {
        return interactor.proceedButtonTitle
    }
    
    var textfieldPlaceholderTitle: String {
        return interactor.textfieldPlaceholderTitle
    }
    
    var hasSetPINSEcurityFactor: Bool {
        return interactor.hasSetPINSecurityFactor
    }
    
    func onProceedAction() {
        if interactor.hasSetPINSecurityFactor {
            interactor.isPinNumberCorrect ? router.presentHomeView() : pinView.displayAsIncorrect()
        } else {
            interactor.setPINPassword()
            router.presentHomeView()
        }
    }
    
    func onSkipSecurityFactorAction() {
        router.presentHomeView()
    }
}

extension PINViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let shoudUpdate = newString.length <= PINInteractor.pinLenght && allowedCharacters.isSuperset(of: characterSet)
        if shoudUpdate {
            interactor.updateInputPinWith(string: newString as String)
            pinView.updatePinDisplayedWith(string: newString as String)
            pinView.updateProceedButtonAs(enabled: interactor.canSubmitPINNumber)
        }
        
        return shoudUpdate
    }
}
