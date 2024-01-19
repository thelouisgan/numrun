import Foundation
import FirebaseDatabase

class numrunViewModel: ObservableObject {
    var ref = Database.database().reference()
    
    // Function to fetch data from Firebase
    func fetchData(completion: @escaping ([numrunDTO]) -> Void) {
        ref.observe(.value) { snapshot in
            var numRunDTOs: [numrunDTO] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let dict = snapshot.value as? [String: Any],
                   let score = dict["score"] as? Int,
                   let answer = dict["answer"] as? Int {
                    let userAnswer = dict["userAnswer"] as? String ?? ""
                    let id = snapshot.key
                    
                    let numRunDTO = numrunDTO(id: id, score: score, userAnswer: userAnswer, answer: answer)
                    numRunDTOs.append(numRunDTO)
                }
            }
            
            completion(numRunDTOs)
        }
    }
    
    // Function to update user answer in Firebase
    func updateUserAnswer(_ answer: String) {
        ref.child("userAnswer").setValue(answer)
    }
    
    // Function to update correct answer in Firebase
        func updateCorrectAnswer(_ answer: Int) {
            ref.child("answer").setValue(answer)
        }
    
    // Function to increment score in Firebase
    func incrementScore() {
        ref.child("score").observeSingleEvent(of: .value) { snapshot in
            if var score = snapshot.value as? Int {
                score += 1
                self.ref.child("score").setValue(score)
            }
        }
    }
}
