//
//  ProfileView.swift
//  MyBuddyDemo

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl

    init(user: CurrentUser, appearance: AppearanceSettings) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user, appearance: appearance))
    }
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Your Info")) {
                    ZStack {
                        AsyncImage(url: viewModel.state.user.imageAsURL) { image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .scaledToFill()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        } placeholder: {
                            Color.gray
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .scaledToFill()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                    }
                    .onTapGesture {
                        appCoordinator.presentSheet(.photoPicker({ image in
                            viewModel.send(.uploadImageProfile(image))
                        }))
                    }
                    TextField(text: $viewModel.state.user.username) {
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Select Appearance", selection: $viewModel.state.appearanceSettings.selectedAppearance) {
                        ForEach(AppearanceSettings.Appearance.allCases, id: \.self) { appearance in
                            Text(appearance.rawValue).tag(appearance)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Toggle("Show online?", isOn: $viewModel.state.user.isOnlineMode)
                }
            }
            .onReceive(viewModel.state.appearanceSettings.$selectedAppearance, perform: { output in
                viewModel.send(.saveAppearance(output))
            })
        }
    }
}

struct UserCardView: View {
    
    let user: UserInfo
    
    init(user: UserInfo) {
        self.user = user
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .center, spacing: 8, content: {
                HStack(alignment: .center, spacing: 16) {
                    Text(user.username ?? "")
                        .font(.system(size: 32, weight: .bold))
                    Circle()
                        .fill(user.isOn ? Color.green : Color.red)
                        .frame(width: 16, height: 16)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom, content: {
                    AsyncImage(url: user.imageAsURL) { image in
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
                        Text(String(user.rateAvg))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                        Text(String(String(format: "(%lld)", user.rates?.count ?? 0)))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.textSecondary)
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
                        .foregroundStyle(Color.textPrimary)
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
            })
            .frame(maxWidth: geometry.frame(in: .local).width)
        })
    }
}
