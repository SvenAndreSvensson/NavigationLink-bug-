//
//  AccountDetailsView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct AccountDetailsView: View {
    @Binding var account: Account
    
    @EnvironmentObject var manager: AccountsManager
    @State private var editData: Account.Data = Account.Data()
    @State private var showEditor = false
    @State private var showAlert = false
    
    var body: some View {
        List {
            
            Section(header: Text(String(localized: "Account"))) {
                
                HStack{
                    Text(String(localized: "Name"))
                        .style(.label)
                    Spacer()
                    Text(account.name)
                        .style(.text)
                }
                
                HStack {
                    Text(String(localized: "Nickname"))
                        .style(.label)
                    Spacer()
                    Text(account.nickname)
                        .style(.text)
                }

            } // Section
                
        } // List
        .listStyle(.insetGrouped)
        .navigationTitle(account.nickname)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(String(localized: "Edit")) {
                    editData = account.data
                    showEditor = true
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            NavigationView {
                AccountEditView(accountData: $editData)
                    .navigationTitle(editData.nickname)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(String(localized: "Cancel")) {
                                showEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(String(localized: "Done")) {
                                account.update(from: editData)
                                showEditor = false
                            }.disabled(editData.name.isEmpty)
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(String(localized: "Delete")) {
                                showAlert = true
                            }
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlert, content: {
                                Alert(
                                    
                                    title: Text("Are you sure you want to delete \(account.nickname)"),
                                    message: Text("There is no undo"),
                                    primaryButton: .destructive(Text(String(localized: "Remove"))) {
                                    
                                    manager.remove(account)
                                    showEditor = false
                                },
                                    secondaryButton: .cancel()
                                )
                            })
                        }
                    }
            }
        }
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsView(account: .constant(Account.data[0]))
    }
}
