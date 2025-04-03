//
//  ContentView.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI

struct BookView: View {
    @StateObject private var viewModel = BooksListViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(viewModel.books.count) item")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top)

                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.books.indices, id: \.self) { index in
                            VStack(spacing: 0) {
                                NavigationLink(destination: BookDetailView(bookID: viewModel.books[index].id)) {
                                    BookRowView(book: viewModel.books[index])
                                        .padding(.horizontal)
                                        .padding(.vertical, 12)
                                }
                                .buttonStyle(.plain)

                                if index != viewModel.books.count - 1 {
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color(.systemGray5))
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .onAppear {
                viewModel.loadBooks()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    BookView()
}
