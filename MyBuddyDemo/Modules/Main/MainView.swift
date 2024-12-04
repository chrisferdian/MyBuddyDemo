//
//  MainView.swift
//  MyBuddyDemo

import Foundation
import SwiftUI

struct MainView: View {

    @StateObject private var viewModel: MainViewModel

    init() {
        _viewModel = StateObject(wrappedValue: MainViewModel())
    }

    var body: some View {
        VStack {
            List(viewModel.state.users, id: \.uid) { user in
                Text(user.uid ?? "")
            }
        }
        .onAppear {
            viewModel.send(.fetchUsers)
        }
    }
}
