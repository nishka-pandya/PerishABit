//
//  testissue.swift
//  
//
//  Created by Scholar on 7/8/26.
//

import SwiftUI

struct testissue: View {
    var body: some View {
        NavigationStack {
            Text("Test")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Test") {}
                    }
                }
        }
        .toolbarBackground(.red, for: .bottomBar)
        .toolbarBackground(.visible, for: .bottomBar)
    }
}

#Preview {
    testissue()
}
