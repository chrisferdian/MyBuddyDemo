//
//  CardImageView.swift
//  MyBuddyDemo
//
struct CardImageView: View {
    let imageUrl: URL?
    let name: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let profileImageURL = imageUrl {
                AsyncImage(url: profileImageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            
            Text(name)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
