/// Copyright (c) 2023 Kodeco LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import AVKit

struct ExcerciseView: View {
  @Binding var selectedTab: Int
  @State private var showHistory = false
  @State private var showSuccess = false
  let index: Int
  var exercise: Exercise{
    Exercise.exercises[index]
  }
  let interval: TimeInterval = 30 ///30 seconds, TimeInterval is an alias for Double
  @State private var rating = 0
  var lastExercise: Bool{ ///Checks if this is the last exercise
    index + 1 == Exercise.exercises.count
  }
  var startButton: some View{
    Button("Start Exercise") {}
  }
  var doneButton: some View{
    Button("Done"){
      if lastExercise{
        showSuccess.toggle()
      }else{
        selectedTab += 1
      }
    }
  }
  var body: some View {
    GeometryReader { geometry in
      VStack{
        HeaderView(selectedTab: $selectedTab, titleText: exercise.exerciseName)
          .padding(.bottom)
        VideoPlayerView(videoName: exercise.videoName)
          .frame(height: geometry.size.height * 0.45) ///Video players uses only 45% of the screen height
        Text(Date().addingTimeInterval(interval), style: .timer)
          .font(.system(size:geometry.size.height * 0.07))
        HStack(spacing: 150){
          startButton
          doneButton
            .sheet(isPresented: $showSuccess, content: {
              SuccessView(selectedTab: $selectedTab)
                .presentationDetents([.medium, .large])
            })
        }
          .font(.title3)
          .padding()
        RatingView(rating: $rating).padding()
        Spacer()
        Button("History"){
          showHistory.toggle()
        }
        .sheet(isPresented: $showHistory, content: {
          HistoryView(showHistory: $showHistory)
        })
          .padding(.bottom)
      }
    }
  }
}

#Preview {
  ExcerciseView(selectedTab: .constant(3), index: 1)
}


