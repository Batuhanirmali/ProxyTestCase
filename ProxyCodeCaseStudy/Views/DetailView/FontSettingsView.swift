//
//  FontSettingsView.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI

struct FontSettingsView: View {
    @Binding var show: Bool
    @Binding var fontSize: CGFloat
    @Binding var selectedTheme: Theme

    let themes: [Theme] = [
        .init(color: Color(hex: "#232323"), textColor: .white),
        .init(color: Color(hex: "#326B55"), textColor: .white),
        .init(color: Color(hex: "#002963"), textColor: .white),
        .init(color: Color(hex: "#FFF0DE"), textColor: .black)
    ]

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 10) {
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.top, 15)

                HStack {
                    Spacer()
                    Button("Done") {
                        withAnimation {
                            show = false
                        }
                    }
                    .foregroundColor(Color(hex: "#F7C663"))
                    .padding(.trailing)
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Text Size")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Text("Aa")
                                .font(.system(size: fontSize))
                                .bold()
                                .foregroundColor(.black)
                        }


                        HStack(spacing: 16) {
                            Button(action: {
                                if fontSize > 10 {
                                    fontSize -= 1
                                }
                            }) {
                                Image(systemName: "minus")
                                    .foregroundStyle(.white)
                                    .frame(width: 30, height: 30)
                                    .background(Color(hex: "#F7C663"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                            Text("\(Int(fontSize))px")
                                .font(.subheadline)
                                .foregroundColor(.black)

                            Button(action: {
                                if fontSize < 100 {
                                    fontSize += 1
                                }
                            }) {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .frame(width: 30, height: 30)
                                    .background(Color(hex: "#F7C663"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding()
                    VStack {
                        Text("Background Color")
                            .font(.subheadline)
                            .foregroundColor(.black)

                        HStack(spacing: 12) {
                            ForEach(themes.indices, id: \.self) { index in
                                let theme = themes[index]
                                Button {
                                    selectedTheme = theme
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(theme.color)
                                            .frame(width: 35, height: 35)
                                        Text("Aa")
                                            .font(.caption)
                                            .foregroundColor(theme.textColor)
                                    }
                                    .overlay(
                                        Circle()
                                            .stroke(selectedTheme == theme ? Color(hex: "#F7C663") : .clear, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.bottom, 50)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
            .ignoresSafeArea(edges: .bottom)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
