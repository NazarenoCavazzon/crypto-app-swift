//
//  UIApplication.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 18/11/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
