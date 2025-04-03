//
//  BookDetail.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

struct BookDetail: Decodable {
    let id: String
    let title: String
    let author: String
    let aboutTheBook: String?
    let readingDuration: Int?
    let numberOfChapters: Int?
    let coverImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, author
        case aboutTheBook = "about_the_book"
        case readingDuration = "reading_duration"
        case numberOfChapters = "number_of_chapters"
        case coverImageUrl = "cover_image_url"
    }
}
