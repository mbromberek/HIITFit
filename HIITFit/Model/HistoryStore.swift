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

import Foundation
struct ExerciseDay: Identifiable{
  let id = UUID()
  let date: Date
  var exercises: [String] = []
}
enum FileError: Error{
  case loadFailure
  case saveFailure
}

class HistoryStore: ObservableObject{
  @Published var exerciseDays: [ExerciseDay] = []
  @Published var loadingError = false
  var dataURL: URL{
    URL.documentsDirectory.appendingPathComponent("history.plist")
  }
  
  init(){
    #if DEBUG
//    createDevData()
    #endif
    do{
      try load()
    }catch{
      loadingError = true
    }
  }
  
  func addDoneExercise(_ exerciseName: String){
    let today = Date()
    ///Can stack up conditionals separating them with a comma.
    if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate){
      //print("Add \(exerciseName)")
      exerciseDays[0].exercises.append(exerciseName)
    }else{
      //print("Insert \(exerciseName)")
      exerciseDays.insert(ExerciseDay(date: today, exercises: [exerciseName]), at: 0)
    }
    do{
      try save()
    }catch{
      fatalError(error.localizedDescription)
    }
  }
  
  func load() throws{
    ///Read History data, if there is no history data the guard let prevent an error and just returns from function.
    guard let data = try? Data(contentsOf: dataURL) else{
      return
    }
    do {
      let plistData = try PropertyListSerialization.propertyList(
        from: data,
        options: [],
        format: nil)
      let convertedPlistData = plistData as? [[Any]] ?? []
      exerciseDays = convertedPlistData.map{
        ExerciseDay(
          date: $0[1] as? Date ?? Date(),
          exercises: $0[2] as? [String] ?? []
        )
      }
    }catch{
      throw FileError.loadFailure
    }
  }
  
  func save() throws{
    /*var plistData: [[Any]] = []
    for exerciseDay in exerciseDays {
      plistData.append(([
        exerciseDay.id.uuidString,
        exerciseDay.date,
        exerciseDay.exercises
      ]))
    }*/
    ///An advantage using map for this is you can make plistData a constant
    /*let plistData: [[Any]] = exerciseDays.map { exerciseDay in
      [
        exerciseDay.id.uuidString,
        exerciseDay.date,
        exerciseDay.exercises
      ]
    }*/
    
    let plistData = exerciseDays.map{
      [$0.id.uuidString, $0.date, $0.exercises]
    }
    
    do {
      let data = try PropertyListSerialization.data(
        fromPropertyList: plistData,
        format: .binary,
        options: .zero)
      try data.write(to: dataURL, options: .atomic)
    } catch {
      throw FileError.saveFailure
    }
  }
}


