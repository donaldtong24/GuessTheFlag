//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Donald Tong on 7/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var gameOver = false
    @State private var questions = 0
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France","Germany","Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK","Ukraine","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.black], startPoint: .top,endPoint:.bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing:15){
                    VStack{
                        Text("Question \(questions+1) out of 8")
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button{
                            //flag was tapped
                            flagTapped(number)
                        } label:{
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius:5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score:\(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $gameOver){
            Button("New Game", action: restartGame)
        }
    }
    func restartGame(){
        questions = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func askQuestion(){
        questions+=1
        if questions == 8{
            gameOver = true
        }
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        
        
        
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
        }
        else{
            scoreTitle = "Wrong thats the flag of \(countries[number])"
            score-=1
           
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
