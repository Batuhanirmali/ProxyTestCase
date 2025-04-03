//
//  BooksListViewModel.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

class BooksListViewModel: ObservableObject {
    @Published var books: [Book] = []

    private let service = BookService()

    func loadBooks() {
        service.fetchBooks { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                case .failure(let error):
                    print("Hata: \(error)")
                }
            }
        }
    }
}
