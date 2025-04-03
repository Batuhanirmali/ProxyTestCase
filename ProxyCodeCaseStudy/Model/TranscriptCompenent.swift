//
//  TranscriptCompenent.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

struct TranscriptComponent: Decodable, Identifiable {
    let id = UUID()
    let start: Double
    let end: Double
    let text: String
    let componentType: String
}

struct TranscriptSection: Decodable {
    let start: Double
    let transcriptComponents: [TranscriptComponent]
}

struct TranscriptResponse: Decodable {
    let sections: [TranscriptSection]
}
