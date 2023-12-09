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

struct RatingView: View {
  let exerciseIndex: Int
  @AppStorage("ratings") private var ratings = "0000"
  @State private var rating = 0
  let maximumRating = 5
  let onColor = Color.red
  let offColor = Color.gray
  
  var body: some View {
    HStack {
      ForEach(0 ..< 5) { index in
        Image(systemName: "waveform.path.ecg")
          .foregroundColor(
            index >= rating ? offColor : onColor
          )
          .onTapGesture {
            updateRating(index: index+1)
          }
          .onAppear{
            let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
            let character = ratings[index]
            rating = character.wholeNumberValue ?? 0 ///If character is not an integer then will get nil so replace with 0
          }
      }
    }.font(.largeTitle)
  }
  
  func updateRating(index: Int){
    rating = index
    let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
    ///Create RangeExpression with index...index and replace the range with the new rating value
    ratings.replaceSubrange(index...index, with: String(rating))
  }
}

struct RatingView_Previews: PreviewProvider{
  @AppStorage("ratings") static var ratings: String?
  static var previews: some View{
    ratings = nil
    return RatingView(exerciseIndex: 0)
      .previewLayout(.sizeThatFits)
  }
}


