import SwiftUI

struct ContentView: View {
    @State private var number1 = Int.random(in: 1...10)
    @State private var number2 = Int.random(in: 1...10)
    @State private var userAnswer = ""
    @State private var feedback = ""
    
    // Injecting the ViewModel
    @ObservedObject var viewModel = numrunViewModel() // Ensure correct capitalization
    
    var body: some View {
        VStack {
            Text("What is \(number1) x \(number2)?")
                .font(.title)
            
            TextField("Your answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Submit") {
                submitAnswer()
            }
            
            Text(feedback)
                .padding()
        }
        .onAppear {
            // Retrieve correct answer from Firebase (if needed)
            viewModel.ref.child("answer").observeSingleEvent(of: .value) { snapshot in
                if let correctAnswer = snapshot.value as? Int {
                    // Use correctAnswer as needed
                    print("Correct Answer:", correctAnswer)
                }
            }
        }
    }
    
    func submitAnswer() {
        if let answer = Int(userAnswer) {
            let correctAnswer = number1 * number2
            
            if answer == correctAnswer {
                feedback = "Correct!"
                
                // Sync userAnswer with Firebase variable
                viewModel.updateUserAnswer("\(answer)")
                
                // Update score if the answer is correct
                viewModel.incrementScore()
            } else {
                feedback = "Wrong Answer, Try Again"
            }
        } else {
            feedback = "Please enter a valid number"
        }
        
        generateQuestion()
    }
    
    func generateQuestion() {
        number1 = Int.random(in: 1...10)
        number2 = Int.random(in: 1...10)
        userAnswer = ""
        feedback = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
