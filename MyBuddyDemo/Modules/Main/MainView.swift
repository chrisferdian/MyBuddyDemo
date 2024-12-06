//
//  MainView.swift
//  MyBuddyDemo

import Foundation
import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel
    
    init(user: UserJSON) {
        _viewModel = StateObject(wrappedValue: MainViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 12) {
            
            CardImageView(
                imageUrl: viewModel.state.users?.imageAsURL,
                name: viewModel.state.users?.uid ?? ""
            )
            .onTapGesture {
                viewModel.state.isImagePickerPresented = true
            }
            .padding(.horizontal, 16)
            .frame(maxHeight: 350)
            
            HStack {
                Text("Zynx")
            }
        }
        .sheet(isPresented: $viewModel.state.isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.state.selectedImage, onImagePicked: { image in
                viewModel.state.selectedImage = image
                viewModel.send(.uploadImageProfile)
            })
        }
        .onAppear {
            viewModel.send(.fetchUsers)
        }
    }
}
