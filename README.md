# 📚 ProxyTestCase Challenge

A SwiftUI-based book listing and detail app built for the **Proksi Yazılım Swift Developer Challenge**. The app features a modern interface, supports reading and listening modes, and uses real-time transcript data to synchronize audio playback.

---

## 🎬 App Preview


<video src="https://github.com/user-attachments/assets/2bea04ab-5e93-40bd-9eaa-320f1df354e9" width="100%" controls></video>

<p align="left"> 
  <img src="https://github.com/user-attachments/assets/19814d78-3566-4dde-9483-4817e1d85c5b" width="250" height="530" />
  <img src="https://github.com/user-attachments/assets/bb7b6957-7884-42cc-a6e6-264d23eaeb1d" width="250" height="530" />
  <img src="https://github.com/user-attachments/assets/da83da71-5613-4ead-ace1-e50a8755b714" width="250" height="530" />
  <img src="https://github.com/user-attachments/assets/33c4bd7b-6bbd-4733-a732-350d22b09f18" width="250" height="530" />
  <img src="https://github.com/user-attachments/assets/d2c32721-7e09-4c93-9816-c43f5a770e9a" width="250" height="530" />
</p>

---

## 📱 Features

- 🔍 Book listing with cover images and basic info
- 📖 Detail view with chapter navigation and transcript
- 🎧 Listen mode with audio playback (AVPlayer)

- 🔁 Dynamic chapter progress bar based on transcript durations
- 🧠 MVVM architecture using Combine for reactive data flow
- 💾 Image caching with SDWebImage
- 🔗 API integration with [Proksi Test API](https://testcase.proksiyazilim.com/docs#)

---

## 🛠️ Tech Stack

| Tool           | Purpose                          |
|----------------|----------------------------------|
| SwiftUI        | UI Framework                     |
| Combine        | Reactive Data Binding            |
| AVFoundation   | Audio Playback                   |
| URLSession     | API Networking                   |
| SDWebImage     | Remote Image Loading & Caching   |
| MVVM           | Clean Architecture               |

---

## 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/ProxyTestCase-Challenge.git
   cd ProxyTestCase-Challenge


## 📝 Known Limitations / To-Do

Due to time constraints, the following features were not fully implemented or are currently incomplete:

- 📖 Chapter tracking on page transitions is not fully functional.
- 🔁 While reading, syncing `ScrollViewReader` with the current text dynamically based on the audio transcript is not yet implemented.
- ✅ Unit tests were not added.
- 🎨 Theme color changes are not saved via `UserDefaults`, so user preferences are not remembered between launches.
- 🔊 The full-screen audio view (with image, dynamic progress bar, and full control buttons) was not completed.
  - The intended design includes a `.presentationDetents([.fraction(0.85)])` behavior that expands when scrolled up and shrinks when scrolled down.
- 📊 The progress bar for audio is not dynamically adjusted based on transcript timings.
  - A timer-based system was planned to sync the bar with the actual spoken text, starting from 0 when playback begins or resumes.
- 🔤 Custom fonts were not integrated; currently using system default fonts.
- 🧾 SwiftUI does not support justified text alignment natively.
  - As a result, the paragraph alignment in the detail screen may look misaligned.
  - This can be resolved using a `UIViewRepresentable` with a `UITextView` to simulate justified text.

These items are on the roadmap for future iterations.
