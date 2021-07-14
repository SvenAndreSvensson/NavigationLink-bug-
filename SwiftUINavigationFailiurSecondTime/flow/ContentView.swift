//
//  ContentView.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var feeManager: FeeManager
    @EnvironmentObject var accontManager: AccountsManager
    
    @State var newFeeData =  FeeNote.Data()
    @State var showEditor = false
    
    var body: some View {
        
        NavigationView {
            VStack{
                List{
                    Section {
                        
                        ForEach($feeManager.fees){ $fee in
                            
                            NavigationLink(destination: FeeDetailsView(fee: $fee, selected: accontManager.account(accountId: fee.accountId))) {
                                HStack {
                                    Text(String(localized:"Note"))
                                    Spacer()
                                    Text(fee.note)
                                }
                            }
                            
                        } // ForEach
                        
                    } // Section
                    
                } // List
                
                VStack{
                    Text("Is it me, or is it a bug?")
                    Spacer()
                }
                
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { showEditor = true }) {
                        Image(systemName: "plus")
                    }
                }
            } // toolbar
            .sheet(isPresented: $showEditor) {
                print("dismiss")
            } content: {
                NavigationView{
                    FeeEditView(feeData: $newFeeData, selected: nil)
                        .navigationTitle(newFeeData.note)
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button(String(localized:"Dismiss")) {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button(String(localized:"Add")) {
                                    
                                    let newFee = FeeNote(
                                        id: UUID(),
                                        note: newFeeData.note,
                                        tradingDay: newFeeData.tradingDay,
                                        accountId: newFeeData.accountId!,
                                        balance: newFeeData.balance)
                                    
                                    feeManager.fees.append(newFee)
                                    
                                    newFeeData = FeeNote.Data()
                                    showEditor = false
                                }
                                .disabled(newFeeData.accountId == nil)
                            }
                        } // toolbar
                } // NavigationView
            } // sheet
        } // NavigationView
    } // body
}

struct detailsView: View {
    var aDetail: String
    var body: some View{
        Text(aDetail)
            .navigationTitle("Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
                .environmentObject(FeeManager())
                .environmentObject(AccountsManager())
        }
    }
}
