//
//  AccountEditView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct AccountEditView: View {
    @Binding var accountData: Account.Data
    
    var body: some View {
        List {
            Section(header: Text(String(localized:"Account"))) {
                
                HStack{
                    Text(String(localized:"Name"))
                        .style(.label)
                    
                    TextField( String(localized: "Write name"), text: $accountData.name)
                        .multilineTextAlignment(.trailing)
                        .disableAutocorrection(true)
                        .textFieldStyle(.automatic)
                        .style(.textField)
                }
                
                HStack{
                    Text(String(localized:"Nickname"))
                        .style(.label)
                    //Spacer()
                    TextField(String(localized:"Write nickname"), text: $accountData.nickname)
                        .multilineTextAlignment(.trailing)
                        .disableAutocorrection(true)
                        .textFieldStyle(.automatic)
                        .style(.textField)
                }
                
            } // Section
            .listRowBackground(Color.gray.opacity(0.3))
            
        } // List
    }
}

struct AccountEditView_Previews: PreviewProvider {
    static var previews: some View {
        AccountEditView(accountData: .constant(Account.data[0].data))
    }
}
