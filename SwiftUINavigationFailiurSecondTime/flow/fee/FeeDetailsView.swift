//
//  FeeDetailsView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct FeeDetailsView: View {
    @Binding var fee: FeeNote
    
    @EnvironmentObject var manager: FeeManager
    @State private var editData: FeeNote.Data = FeeNote.Data()
    @State private var showEditor = false
    @State private var showAlert = false
    
    @EnvironmentObject var accontManager: AccountsManager
    @State private var account: Account
    
    init(fee: Binding<FeeNote>, selected: Account?){
        _fee = fee
        _account =  State(initialValue: selected ?? Account.zero)
    }
    
    var body: some View {
        List {
            Section(header: Text(String(localized: "Fee"))) {
                HStack{
                    Text(String(localized: "Note"))
                        .style(.label)
                    Spacer()
                    Text(fee.note)
                        .style(.text)
                }
                HStack {
                    Text(String(localized: "traiding day"))
                        .style(.label)
                    Spacer()
                    Text(fee.tradingDay.string("dd.MM.yyyy"))
                        .style(.text)
                }
                
                HStack {
                    Text(String(localized: "Balance"))
                        .style(.label)
                    Spacer()
                    Text(fee.balance.fixed(precision: 1))
                        .style(.text)
                }
                
            } // Section
            
            Section(header: Text(String(localized: "Relations"))) {
             
                NavigationLink(destination: AccountDetailsView(account: $account)) {
                    HStack {
                        Text(String(localized:"Account"))
                            .style(.label)
                        Spacer()
                        Text(account.nickname)
                            .style(.text)
                    }
                }
                
            } // Section
                
        } // List
        .listStyle(.insetGrouped)
        .navigationTitle(fee.note)
        /*.onAppear(perform: {
            print("FeeDetailsView onAppear")
            account = accontManager.account(accountId: fee.accountId)
            //editData = fee.data
            
        })*/
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(String(localized: "Edit")) {
                    editData = fee.data
                    showEditor = true
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            NavigationView {
                FeeEditView(feeData: $editData, selected: accontManager.account(accountId: fee.accountId))
                    .navigationTitle(editData.note)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(String(localized: "Cancel")) {
                                showEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(String(localized: "Done")) {
                            
                                fee.update(from: editData)
                                account = accontManager.account(accountId: fee.accountId)
                                showEditor = false
                                
                            }.disabled(editData.note.isEmpty)
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(String(localized: "Delete")) {
                                showAlert = true
                            }
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlert, content: {
                                Alert(
                                    // TODO: localize
                                    title: Text("Are you sure you want to delete \(fee.note)"),
                                    message: Text("There is no undo"),
                                    primaryButton: .destructive(Text(String(localized: "Remove"))) {
                                    
                                    if let _fee = manager.fee(feeId: fee.id) {
                                        manager.remove(_fee)
                                    }
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

struct FeeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FeeDetailsView(fee: .constant(FeeNote.data[0]), selected: Account.data[0])
    }
}
