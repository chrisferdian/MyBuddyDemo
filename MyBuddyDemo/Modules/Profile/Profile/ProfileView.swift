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
