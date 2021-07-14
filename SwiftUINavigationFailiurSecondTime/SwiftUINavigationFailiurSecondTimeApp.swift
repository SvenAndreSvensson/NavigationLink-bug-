//
//  SwiftUINavigationFailiurSecondTimeApp.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

@main
struct SwiftUINavigationFailiurSecondTimeApp: App {
    
    @StateObject var accountManager = AccountsManager()
    @StateObject var feeManager = FeeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(accountManager)
                .environmentObject(feeManager)
        }
    }
}
