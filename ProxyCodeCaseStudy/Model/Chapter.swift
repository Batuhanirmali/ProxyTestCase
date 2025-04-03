//
//  Chapter.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

struct Chapter: Identifiable {
    let id = UUID()
    let title: String
    let start: Double
}

struct MetadataResponse: Decodable {
    let chapters: [MetadataChapter]
    let urls: BookUrls
}

struct BookUrls: Decodable {
    let htmlFileS3Url: String
    let transcriptJsonFileS3Url: String
    let mergedAudioFileS3Url: String

    enum CodingKeys: String, CodingKey {
        case htmlFileS3Url = "html_file_s3_url"
        case transcriptJsonFileS3Url = "transcript_json_file_s3_url"
        case mergedAudioFileS3Url = "merged_audio_file_s3_url"
    }
}

struct MetadataChapter: Decodable {
    let start: Double
    let text: String
}
