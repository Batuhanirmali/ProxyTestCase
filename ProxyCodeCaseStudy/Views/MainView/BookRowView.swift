//
//  BookRowView.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookRowView: View {
    let book: Book

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            WebImage(url: URL(string: book.coverImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 96)
                .cornerRadius(8)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(book.aboutTheBook ?? "")
                    .font(.caption)
                    .lineLimit(2)
                    .foregroundColor(.gray)

                if let minutes = book.readingDuration {
                    HStack {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 15,height: 15)
                            Text("\(minutes) min")
                        }
                        .font(.caption)
                        .foregroundColor(Color(hex: "#F7C663"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 43)
                                .stroke(Color(hex: "#F7C663"), lineWidth: 1)
                        )

                        Spacer()

                        Button(action: {
                            print("More options tapped for: \(book.title)")
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 4)
                }
            }

        }
    }
}

#Preview {
    let sampleBook = Book(
        id: "1",
        title: "Sample Book Title",
        author: "Jane Doe",
        aboutTheBook: "This is a short description of the book. It gives insight into what the book is about.",
        readingDuration: 15,
        coverImageUrl: "https://d2pv0sxfldss7j.cloudfront.net/img_storage/67dad64e0cd52686d1bd24a4.png"
    )
    
    return BookRowView(book: sampleBook)
        .padding()
}
