//
//  BookService.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

class BookService {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "https://testcase.proksiyazilim.com/api/books/") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
