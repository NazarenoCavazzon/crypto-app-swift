//
//  String.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 22/02/2023.
//

import Foundation

extension String {
    
    var removingHTMLOcurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
