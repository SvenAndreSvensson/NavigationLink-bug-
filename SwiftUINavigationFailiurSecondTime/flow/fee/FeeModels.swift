//
//  FeeModels.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//
import Foundation
import SwiftUI

class FeeManager: ObservableObject{
    @Published var fees: [FeeNote] = FeeNote.data
    
    func fee(feeId id: UUID?) -> FeeNote? {
        if id != nil, let i = self.fees.firstIndex(where: {$0.id == id}) {
            return fees[i]
        }
        return nil
    }
    func remove(_ fee: FeeNote){
        guard let index = fees.firstIndex(of: fee) else {
            print("Can´t remove fee. fee not found!")
            return
        }
        fees.remove(at: index)
    }
}

struct FeeNote: Identifiable, Equatable, Codable {
    var id: UUID
    var note: String
    var tradingDay: Date
    var accountId: UUID?
    var balance: Double
}

extension FeeNote {
    struct Data {
        var note: String = ""
        var tradingDay: Date = Date.now
        var accountId: UUID? = nil
        var balance: Double = 0.0
    }

    mutating func update(from data: Data){
        self.note = data.note
        self.tradingDay = data.tradingDay
        self.accountId = data.accountId
        self.balance = data.balance
    }
    
    var data: Data {
        return Data(note: note, tradingDay: tradingDay, accountId: accountId, balance: balance)
    }
    
    static var data:[FeeNote] {
        [
            FeeNote(id: UUID(uuidString: "91781F36-A5AD-48B8-AEFB-247738DA39EE")!, note:"Note a", tradingDay: Date.now,  accountId: UUID(uuidString: "E14B0B42-15A2-4EBE-8C2B-31E705AD85B6")!, balance: 0.0),
            FeeNote(id: UUID(uuidString: "ECA1AAFC-D710-4AA8-A21B-D07393595160")!, note:"Car wash", tradingDay: Date.now,  accountId: UUID(uuidString: "642C9A77-D9C8-45C3-8D11-71CF7B5D897B")!, balance: 0.0)
            
        ]
    }
}


