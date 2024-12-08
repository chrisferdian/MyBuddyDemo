//
//  UserCardView.swift
//  MyBuddyDemo
//

import SwiftUI

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
                            .frame(width: geometry.frame(in: .local).width * 0.8, height: geometry.frame(in: .local).height * 0.6)
                            .scaledToFill()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    } placeholder: {
                        Color.gray
                            .frame(width: geometry.frame(in: .local).width * 0.8, height: geometry.frame(in: .local).height * 0.6)
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
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                        Text(String(String(format: "(%lld)", user.rates?.count ?? 0)))
                            .font(.system(size: 16, weight: .bold))
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
                    HStack(alignment: .center, spacing: 0) {
                        Text(user.priceFormatted)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                        Text("/1Hr")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.textSecondary)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
            })
            .frame(maxWidth: geometry.frame(in: .local).width)
        })
    }
}
