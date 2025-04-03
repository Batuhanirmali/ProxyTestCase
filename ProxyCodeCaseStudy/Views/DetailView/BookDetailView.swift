//
//  Untitled.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
    let bookID: String
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = BookDetailViewModel()
    @StateObject var player = AudioPlayerViewModel()
    @State private var selectedMode: Mode = .read
    enum Mode { case read, listen }
    @State private var showListenOverlay = false
    @State private var showFontSettings = false
    @State private var fontSize: CGFloat = 17
    @State private var selectedTheme: Theme = Theme(color: .white, textColor: .black)
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss() 
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundStyle(selectedTheme.textColor)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            print("List button tapped")
                        }) {
                            Image("list-ui-alt")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(selectedTheme.textColor)
                                .frame(width: 29, height: 29)
                        }
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                    showFontSettings = true
                                }
                        }) {
                            Image("letter-english-a")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(selectedTheme.textColor)
                                .frame(width: 29, height: 29)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                ChapterProgressBar(
                    durations: viewModel.chapterDurations,
                    current: viewModel.currentChapterIndex
                )
                .frame(height: 4)
                .padding(.bottom, 8)
                
                if let book = viewModel.detail {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            // Kitap bilgileri
                            HStack(alignment: .top, spacing: 12) {
                                WebImage(url: URL(string: book.coverImageUrl ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(book.author)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundStyle(selectedTheme.textColor)

                                    if let duration = book.readingDuration,
                                       let chapters = book.numberOfChapters {
                                        Text("\(duration) min • \(chapters) chapters")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                                .padding(.vertical, 8)
                            
                            if viewModel.chapters.indices.contains(viewModel.currentChapterIndex) {
                                let chapter = viewModel.chapters[viewModel.currentChapterIndex]
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(chapter.title)
                                        .font(.headline)
                                        .foregroundStyle(selectedTheme.textColor)

                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(viewModel.transcriptForCurrentChapter().filter { $0.componentType == "text" }) { component in
                                            let isActive = player.currentTime + 1.5 >= component.start && player.currentTime + 1.5 <= component.end

                                            Text(component.text)
                                                .font(.system(size: fontSize))
                                                .foregroundStyle(selectedTheme.textColor)
                                                .padding(4)
                                                .background(
                                                    isActive ? Color.yellow.opacity(0.4) : Color.clear
                                                )
                                                .cornerRadius(8)
                                                .animation(.linear(duration: 0.1), value: isActive)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Page Navigator + Mode Switch
                    VStack(spacing: 8) {
                        HStack {
                            Button(action: {
                                if viewModel.currentChapterIndex > 0 {
                                    viewModel.currentChapterIndex -= 1
                                }
                            }) {
                                Image(systemName: "chevron.backward.circle")
                                    .resizable()
                                    .frame(width: 24,height: 24)
                                    .foregroundStyle(selectedTheme.textColor)
                            }
                            
                            Text("Page \(viewModel.currentChapterIndex + 1) of \(viewModel.chapters.count)")
                                .font(.subheadline)
                                .foregroundStyle(selectedTheme.textColor)
                                .padding(.horizontal, 30)
                            
                            Button(action: {
                                if viewModel.currentChapterIndex < viewModel.chapters.count - 1 {
                                    viewModel.currentChapterIndex += 1
                                }
                            }) {
                                Image(systemName: "chevron.right.circle")
                                    .resizable()
                                    .frame(width: 24,height: 24)
                                    .foregroundStyle(selectedTheme.textColor)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 0) {
                            // READ Button
                            Button(action: { selectedMode = .read }) {
                                ZStack {
                                    if selectedMode == .read {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(hex: "#F7C663"))
                                    }
                                    
                                    Image(systemName: "text.alignleft")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(selectedMode == .read ? .white : Color(hex: "#F7C663"))
                                }
                                .frame(width: 84, height: 43)
                            }
                            
                            // LISTEN Button
                            Button(action: {
                                selectedMode = .listen
                                showListenOverlay = true
                            }) {
                                ZStack {
                                    if selectedMode == .listen {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(hex: "#F7C663"))
                                    }
                                    
                                    Image(systemName: "headphones")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(selectedMode == .listen ? .white : Color(hex: "#F7C663"))
                                }
                                .frame(width: 84, height: 43)
                            }
                            
                        }
                        .frame(width: 176, height: 51)
                        .foregroundStyle(selectedTheme.color)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "#E7E7E7"), lineWidth: 1)
                        )
                    }
                } else {
                    ProgressView()
                }
            }
            .background(selectedTheme.color)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.loadDetail(id: bookID)
                viewModel.loadMetadata(id: bookID)
                viewModel.loadTranscript(id: bookID)
            }
            .sheet(isPresented: $showListenOverlay, onDismiss: {
                selectedMode = .read
            }) {
                if let url = viewModel.audioURL {
                    ListenOverlayView(audioURL: url, player: player, viewModel: viewModel)
                        .presentationDetents([.fraction(0.25)])
                        .presentationDragIndicator(.visible)
                } else {
                    Text("Audio URL not available")
                }
            }
            
            if showFontSettings {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showFontSettings = false
                        }
                    }
                
                FontSettingsView(
                    show: $showFontSettings,
                    fontSize: $fontSize,
                    selectedTheme: $selectedTheme
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .ignoresSafeArea(edges: .bottom)
            }
        }
        
    }
}


