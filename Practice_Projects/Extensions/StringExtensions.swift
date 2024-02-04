//
//  StringExtensions.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 20/07/2023.
//

import Foundation

extension String {
    func localizeString() -> String {
        let language = NSLocale.current.languageCode
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
