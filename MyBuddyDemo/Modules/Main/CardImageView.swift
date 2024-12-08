//
//  CardImageView.swift
//  MyBuddyDemo
//

import SwiftUI

struct CardImageView: View {
    let user: UserInfo?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let profileImageURL = user?.imageAsURL {
                ZStack(alignment: .bottom) {
                    Color.red
                        .frame(height: 300)
                        .overlay {
                            AsyncImage(url: profileImageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 300)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                        .contentShape(Rectangle())

                    GamesView()
                        .padding(.bottom, -16)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.purple)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
