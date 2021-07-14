//
//  FeeEditView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct FeeEditView: View {
    @Binding var feeData: FeeNote.Data
    
    @EnvironmentObject var accountsManager: AccountsManager
    @State private var account: Account?
    
    init(feeData: Binding<FeeNote.Data>, selected: Account?){
        _feeData = feeData
        _account =  State(initialValue: selected)
    }
    
    var body: some View {
        List {
            Section(header: Text(String(localized:"Fee"))) {
                
                HStack{
                    Text(String(localized:"Note"))
                        .style(.label)
                    
                    TextField( String(localized: "Write a note"), text: $feeData.note)
                        .multilineTextAlignment(.trailing)
                        .disableAutocorrection(true)
                        .textFieldStyle(.automatic)
                        .style(.textField)
                }
                
                DatePicker("TradingDay", selection: $feeData.tradingDay)
                
            } // Section
            
            Section(header: Text(String(localized: "Relations"))) {
                
                NavigationLink {
                    AccountPickerView(selection: $account)
                        .onChange(of: account) { newValue in
                           
                            feeData.accountId = account?.id
                        }
                        
                } label: {
                    
                    HStack{
                        Text(String(localized:"Account"))
                            .style(.label)
                        Spacer()
                        Text(account?.nickname ?? "select account" )
                            .style(.text)
                    }
                }
                
            } // Section
            .listRowBackground(Color.gray.opacity(0.3))
            
        } // List
    }
}

struct FeeEditView_Previews: PreviewProvider {
    static var previews: some View {
        FeeEditView(feeData: .constant(FeeNote.data[0].data), selected: Account.data[0])
    }
}
