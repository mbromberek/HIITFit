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

struct HeaderView: View {
  @Binding var selectedTab: Int
  let titleText: String
  var body: some View {
    let fontColor = Color.teal
    VStack{
      Text(titleText)
        .font(.largeTitle)
        .foregroundColor(fontColor)
        .fontWeight(.black)
        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
      HStack{
        ForEach(Exercise.exercises.indices, id: \.self){ index in
          ///Pre ch09 Challenge
          /*let fill = index == selectedTab ? ".fill": ""
          Image(systemName: "\(index + 1).circle\(fill)")
            .onTapGesture {
              selectedTab = index
            }*/
          ///My solution
          let opacity = index == selectedTab ? 0.5: 0
          /*
          ZStack{
            Image(systemName: "circle.fill")
              .onTapGesture {
                selectedTab = index
              }
              .foregroundColor(.white)
              .font(.largeTitle)
              .opacity(opacity)
            Image(systemName: "circle.fill")
              .onTapGesture {
                selectedTab = index
              }
              .foregroundColor(.white)
              .font(.title3)
          }*/
          ///Solution from boolk
          ZStack {
            Circle()
              .frame(width: 32, height: 32)
              .foregroundColor(fontColor)
              .opacity(opacity)
            Circle()
              .frame(width: 16, height: 16)
              .foregroundColor(fontColor)
          }
          .onTapGesture {
            selectedTab = index
          }
        }

      }
      .font(.title2)
    }
  }
}

#Preview {
  HeaderView(selectedTab: .constant(0), titleText: "Squat")
    .previewLayout(/*@START_MENU_TOKEN@*/.sizeThatFits/*@END_MENU_TOKEN@*/)
}
