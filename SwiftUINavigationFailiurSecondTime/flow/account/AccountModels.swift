//
//  AccountModels.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import Foundation
import SwiftUI

class AccountsManager: ObservableObject{
    @Published var accounts: [Account] = Account.data
    
    func remove(_ account: Account){
        guard let index = accounts.firstIndex(of: account) else {
            print("Can´t remove account. account not found!")
            return
        }
        accounts.remove(at: index)
    }
    
    func account(accountId: UUID?) -> Account {
        if accountId == nil { return Account.zero }
        if let _account = accounts.first(where: { account in account.id == accountId }) {
            return _account
        }
        return Account.zero
    }
}

struct Account: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var name: String
    var nickname: String
}

extension Account {
    struct Data {
        var name: String = ""
        var nickname: String = ""
    }

    mutating func update(from data: Data){
        self.name = data.name
        self.nickname = data.nickname
    }
    
    var data: Data {
        return Data(name: name, nickname: nickname)
    }
    
    static var data:[Account] {
        [
            Account(id: UUID(uuidString: "E14B0B42-15A2-4EBE-8C2B-31E705AD85B6")!, name: "Zero", nickname: "IKZ"),
            Account(id: UUID(uuidString: "A0675E14-A633-4887-A592-2899466C9A27")!, name: "Super", nickname: "SUP"),
            Account(id: UUID(uuidString: "642C9A77-D9C8-45C3-8D11-71CF7B5D897B")!, name: "Bad", nickname: "BAD")
        ]
    }
    static var zero = Account(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, name: "no account", nickname: "none")
}
