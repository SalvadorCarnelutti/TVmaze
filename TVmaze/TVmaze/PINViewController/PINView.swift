//
//  PINView.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol PresenterToViewPINProtocol: UIView {
    var presenter: ViewToPresenterVPINProtocol? { get set }
    func updatePinDisplayedWith(string: String)
    func setupViewWith(securityFactorSet: Bool)
    func updateProceedButtonAs(enabled: Bool)
    func displayAsIncorrect()
}

final class PINView: UIViewNibLoadable {
    // MARK: Properties
    private var numberDisplayerView: PINNumberDisplayerView?
    weak var presenter: ViewToPresenterVPINProtocol?
    
    // MARK: IBOutlets
    @IBOutlet weak var headingTitle: UILabel! {
        didSet {
            headingTitle.font = UIFont.boldSystemFont(ofSize: 36.0)
        }
    }
    
    @IBOutlet weak var numberDisplayerContainer: UIView!
    
    @IBOutlet weak var errorMessageLabel: UILabel! {
        didSet {
            errorMessageLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var pinTextfield: UITextField! {
        didSet {
            pinTextfield.keyboardType = .numberPad
            pinTextfield.textAlignment = .center
            pinTextfield.attributedPlaceholder = NSAttributedString(string: "LoginTextfiledPlaceholder".localized(),
                                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                                                                 NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var proceedButton: StyledButton! {
        didSet {
            proceedButton.styleAs(enabled: false)
        }
    }
    
    @IBOutlet weak var skipButton: StyledButton! {
        didSet {
            skipButton.setTitle("LoginSkipSecurityFactor".localized(), for: .normal)
            skipButton.styleAs(enabled: true)
        }
    }
    
    
    @IBOutlet weak var disclamerLabel: UILabel! {
        didSet {
            disclamerLabel.text = "LoginDisclaimer".localized()
            disclamerLabel.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    // MARK: IBActions
    @IBAction func onProceedAction(_ sender: Any) {
        presenter?.onProceedAction()
    }
    
    @IBAction func onSkipSecurityFactorAction(_ sender: Any) {
        presenter?.onSkipSecurityFactorAction()
    }
    
    private func setupPinView() {
        let numberDisplayer = PINNumberDisplayerView(frame: CGRect.zero)
        numberDisplayer.fixInView(numberDisplayerContainer)
        numberDisplayer.setupImages()
        numberDisplayerView = numberDisplayer
    }
}

// MARK: PresenterToViewPINProtocol
extension PINView: PresenterToViewPINProtocol {
    func displayAsIncorrect() {
        numberDisplayerView?.displayAsIncorrect()
        proceedButton.styleAs(enabled: false)
        errorMessageLabel.isHidden = false
    }
    
    func updatePinDisplayedWith(string: String) {
        errorMessageLabel.isHidden = true
        numberDisplayerView?.updateWith(stringNumber: string)
    }

    func setupViewWith(securityFactorSet: Bool) {
        setupPinView()
        pinTextfield.delegate = presenter

        headingTitle.text = presenter?.headingTitle
        proceedButton.setTitle(presenter?.proceedButtonTitle, for: .normal)
        skipButton.isHidden = securityFactorSet
        disclamerLabel.isHidden = securityFactorSet
    }
    
    func updateProceedButtonAs(enabled: Bool) {
        proceedButton.styleAs(enabled: enabled)
    }
}
