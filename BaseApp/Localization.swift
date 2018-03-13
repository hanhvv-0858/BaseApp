//
//  File.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 3/13/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    @objc func onUpdateLocale() {
        for subView: UIView in self.subviews {
            subView.onUpdateLocale()
        }
    }
}

extension String {
    var localized: String {
        return Localization.shared.localized(self)
    }
}

class LocalizableLabel: UILabel {
    
    private var localizeKey: String?
    override public var text: String? {
        set (newValue) {
            self.localizeKey = newValue
            if let key = newValue {
                let localizedString = key.localized
                super.text = localizedString
            } else {
                super.text = newValue
            }
        }
        get {
            return super.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.localizeKey = self.text
        self.text = self.localizeKey
    }
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        self.text = self.localizeKey
    }
    
}

class LocalizableButton: UIButton {
    
    private var localizeKey: String?
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        if let key = title {
            self.localizeKey = key
            let localizedString = key.localized
            super.setTitle(localizedString, for: state)
        } else {
            super.setTitle(title, for: state)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.localizeKey = self.currentTitle
        self.setTitle(self.localizeKey, for: .normal)
    }
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        self.setTitle(self.localizeKey, for: .normal)
    }
    
    func setLocalizedTitle(_ title: String?) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .selected)
    }
    
}

class LocalizableTextField: UITextField {
    
    private var localizeKey: String?
    
    override public var placeholder: String? {
        set (newValue) {
            self.localizeKey = newValue
            if let key = newValue {
                let localizedString = key.localized
                super.placeholder = localizedString
            } else {
                super.placeholder = newValue
            }
        }
        get {
            return super.placeholder
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.localizeKey = self.placeholder
        self.placeholder = self.localizeKey
    }
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        self.placeholder = self.localizeKey
    }
    
}


class Localization {
    
    enum Language {
        case langEn
        case langJA
    }
    
    let langAppEN = "en"
    let langAppJA = "ja"
    let currentLang = "currentLocaleBaseApp"
    
    private var enBundle = Bundle()
    private var jaBundle = Bundle()
    
    func getCurrentLocale() -> String {
        if let locale = UserDefaults.standard.value(forKey: currentLang) as? String {
            return locale
        }
        return langAppEN
    }
    
    func setCurrentLocale(_ lang: Language) {
        switch lang {
        case .langEn:
            UserDefaults.standard.do {
                $0.set(langAppEN, forKey: currentLang)
                $0.synchronize()
            }
        case .langJA:
            UserDefaults.standard.do {
                $0.set(langAppJA, forKey: currentLang)
                $0.synchronize()
            }
        }
    }

    static let shared = Localization()
    
    private init() {
        if let enBundlePath = Bundle.main.path(forResource: langAppEN, ofType: "lproj"), let bundle = Bundle(path: enBundlePath) {
            enBundle = bundle
        }
        if let jaBundlePath = Bundle.main.path(forResource: langAppJA, ofType: "lproj"), let bundle = Bundle(path: jaBundlePath) {
            jaBundle = bundle
        }
    }
    
    
    func localized(_ key: String) -> String { // return String with currentLocale
        var bundle = Bundle()
        switch getCurrentLocale() {
        case langAppEN:
            bundle = enBundle
        default:
            bundle = jaBundle
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: key)
    }
    
    func localized(_ key: String, _ locale: String) -> String { // return String from locale
        var bundle = Bundle()
        switch locale {
        case langAppEN:
            bundle = enBundle
        case langAppJA:
            bundle = jaBundle
        default:
            if let langBundlePath = Bundle.main.path(forResource: locale, ofType: "lproj"), let langBundle = Bundle(path: langBundlePath) {
                bundle = langBundle
            }
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: key)
    }
    
    func en(_ key: String) -> String { // retun String EN
        return NSLocalizedString(key, tableName: nil, bundle: enBundle, value: key, comment: key)
    }
    
    func ja(_ key: String) -> String { // return String JA
        return NSLocalizedString(key, tableName: nil, bundle: jaBundle, value: key, comment: key)
    }
}
