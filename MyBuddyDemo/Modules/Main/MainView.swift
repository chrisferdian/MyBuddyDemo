//
//  MainView.swift
//  MyBuddyDemo

import Foundation
import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl

    init(user: CurrentUser) {
        _viewModel = StateObject(wrappedValue: MainViewModel(user: user))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            switch viewModel.state.viewState {
            case .loading:
                contentView(isLoading: true)
            case .done:
                contentView(isLoading: false)
            case .error:
                errorView
            }
        }
        .onViewDidLoad {
            viewModel.send(.fetchUsers)
        }
    }
    
    var errorView: some View {
        VStack {
            Text("Oops! Unable to connect. Please check your internet connection and try again.")
                .font(.title)
                .padding(.bottom, 20)
            Button(action: {
                viewModel.send(.fetchUsers)
            }) {
                Text("Reload")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    @ViewBuilder
    func contentView(isLoading: Bool) -> some View {
        Text(String(format: "Hi, %@", viewModel.state.user.username))
            .font(.system(size: 32, weight: .semibold))
            .padding(.horizontal, 24)
            .redacted(if: isLoading)
        if let cardModel = viewModel.state.cardModel {
            SwipeableCardsView(
                ViewBuilder: { _model in
                    AnyView(
                        UserCardView(user: _model)
                    )
                }, model: cardModel) { _model in
                    print(_model.swipedCards)
                    _model.reset()
                }
        } else {
            Spacer()
        }
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        ProgressView()
    }
}
