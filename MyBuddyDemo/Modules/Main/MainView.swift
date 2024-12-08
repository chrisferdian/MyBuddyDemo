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
        VStack(spacing: 12) {
            if let cardModel = viewModel.state.cardModel {
                SwipeableCardsView(
                    ViewBuilder: { _model in
                        AnyView(
                            GeometryReader(content: { geometry in
                                VStack(alignment: .center, spacing: 8, content: {
                                    HStack(alignment: .center, spacing: 16) {
                                        Text(_model.username ?? "")
                                            .font(.system(size: 32, weight: .bold))
                                        Circle()
                                            .fill(_model.isOn ? Color.green : Color.red)
                                            .frame(width: 16, height: 16)
                                        Spacer()
                                    }
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                    
                                    ZStack(alignment: .bottom, content: {
                                        AsyncImage(url: _model.imageAsURL) { image in
                                            image
                                                .resizable()
                                                .frame(width: geometry.frame(in: .local).width * 0.85, height: geometry.frame(in: .local).height * 0.7)
                                                .scaledToFill()
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                        } placeholder: {
                                            Color.gray
                                                .frame(width: geometry.frame(in: .local).width * 0.85, height: geometry.frame(in: .local).height * 0.7)
                                                .scaledToFit()
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                        GamesView()
                                            .frame(maxWidth: geometry.size.width *  0.8)
                                            .padding(.bottom, -32)                                            
                                    })
                                    .padding(.top, 16)
                                    
                                    HStack(alignment: .center, spacing: 8) {
                                        Image("star")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        HStack(alignment: .center, spacing: 0) {
                                            Text(String(_model.rateAvg))
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(Color.black)
                                            Text(String(String(format: "(%lld)", _model.rates?.count ?? 0)))
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(Color.gray)
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)

                                    HStack(alignment: .center, spacing: 8) {
                                        Image("mana")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("110")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(Color.black)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    Spacer()
                                })
                                .frame(maxWidth: geometry.frame(in: .local).width)
                            })
                        )
                    }, model: cardModel) { _model in
                        print(_model.swipedCards)
                        _model.reset()
                    }
            }
        }
        .onAppear {
            viewModel.send(.fetchUsers)
        }
    }
}
