//
//  BookDetailViewModel.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import Foundation

class BookDetailViewModel: ObservableObject {
    @Published var detail: BookDetail?
    @Published var currentChapterIndex: Int = 0
    @Published var chapters: [Chapter] = []
    @Published var transcriptSections: [TranscriptSection] = []
    @Published var audioURL: URL?
    
    private let service = BookDetailService()
    var chapterDurations: [Double] {
        guard !transcriptSections.isEmpty else { return Array(repeating: 1.0, count: chapters.count) }

        return transcriptSections.map { section in
            let duration = section.transcriptComponents.reduce(0) { total, component in
                total + (component.end - component.start)
            }
            return max(1.0, duration)
        }
    }
    
    func loadDetail(id: String) {
        service.fetchDetail(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self.detail = detail
                    print("📘 Book detail loaded: \(detail.title)")
                case .failure(let error):
                    print("Detail error: \(error)")
                }
            }
        }
    }
    
    func loadMetadata(id: String) {
        service.fetchMetadata(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let metadata):
                    self.chapters = metadata.chapters.map {
                        Chapter(title: $0.text, start: $0.start)
                    }
                    self.audioURL = URL(string: metadata.urls.mergedAudioFileS3Url)
                    print("🎧 Audio URL:", self.audioURL ?? "nil")
                case .failure(let error):
                    print("Metadata error: \(error)")
                }
            }
        }
    }
    
    func loadTranscript(id: String) {
        service.fetchTranscript(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transcript):
                    self.transcriptSections = transcript.sections
                case .failure(let error):
                    print("Transcript error: \(error)")
                }
            }
        }
    }
    
    
    func transcriptForCurrentChapter() -> [TranscriptComponent] {
        guard chapters.indices.contains(currentChapterIndex) else { return [] }
        let chapterStart = chapters[currentChapterIndex].start
        guard let section = transcriptSections.last(where: { $0.start <= chapterStart }) else { return [] }
        return section.transcriptComponents
    }
}
