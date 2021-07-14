//
//  AccountPickerView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct AccountPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selection: Account?
    
    @EnvironmentObject var manager: AccountsManager
    
    @State private var showEditor = false
    @State private var newData = Account.Data()
    
    var body: some View {
        List(manager.accounts, id: \.self, selection: $selection) { account in
            Text(account.nickname)
        }
        .environment(\.editMode, .constant(EditMode.active))
        .navigationTitle(String(localized:"Accounts"))
        .onChange(of: selection, perform: { newValue in
            dismiss()
        })
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showEditor = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showEditor) {
            NavigationView{
                AccountEditView(accountData: $newData)
                    .navigationTitle(newData.nickname)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(String(localized:"Dismiss")) {
                                showEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(String(localized:"Add")) {
                                
                                let newAccount = Account(
                                    id: UUID(),
                                    name: newData.name,
                                    nickname: newData.nickname
                                    )
                                    
                                manager.accounts.append(newAccount)
                                
                                newData = Account.Data()
                                showEditor = false
                                
                            }
                            .disabled(newData.nickname.isEmpty)
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
}

struct AccountPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AccountPickerView(selection: .constant(Account.data[0]))
                .environmentObject(AccountsManager())
        }
    }
}
