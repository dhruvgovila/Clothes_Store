//
//  ProgressView.swift
//  Clothes Store
//
//  Created by dgovila on 03/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

/// Custom Progress View
struct CustomProgressView: View {
    
    // Variables
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryColor))
            .scaleEffect(1.5, anchor: .center)
    }
}
