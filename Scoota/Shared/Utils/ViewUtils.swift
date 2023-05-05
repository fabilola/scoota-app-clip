//
//  ViewUtils.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import Foundation
import SwiftUI

func getIcon (systemName: String) -> Image {
    if  UIImage(systemName: systemName) != nil {
        return Image(systemName: systemName)
    } else {
        return Image(systemName)
    }
}
