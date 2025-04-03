//
//  BookDetailService.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

class BookDetailService {
    func fetchDetail(for id: String, completion: @escaping (Result<BookDetail, Error>) -> Void) {
        guard let url = URL(string: "https://testcase.proksiyazilim.com/api/books/book/\(id)") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let detail = try JSONDecoder().decode(BookDetail.self, from: data)
                completion(.success(detail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMetadata(for id: String, completion: @escaping (Result<MetadataResponse, Error>) -> Void) {
        guard let url = URL(string: "https://testcase.proksiyazilim.com/api/books/metadata/\(id)") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let metadata = try JSONDecoder().decode(MetadataResponse.self, from: data)
                completion(.success(metadata))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTranscript(for id: String, completion: @escaping (Result<TranscriptResponse, Error>) -> Void) {
        guard let url = URL(string: "https://testcase.proksiyazilim.com/api/books/transcript/\(id)") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let transcript = try JSONDecoder().decode(TranscriptResponse.self, from: data)
                completion(.success(transcript))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
