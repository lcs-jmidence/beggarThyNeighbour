//
//  main.swift
//  beggarThyNeighbour
//
//  Created by Midence Rosario, Julio on 2020-02-20.
//  Copyright © 2020 Julio Midence. All rights reserved.
//

import Foundation



//actual structure for the game
struct BeggarThyNeigbourGame {
    
    //create two players to play
    var player1: Hand = Hand(description: "player1")
    var player2: Hand = Hand(description: "player2")
    
    //create offence and defence indicators
    var offence: Hand
    var defence: Hand
    
    //create a pot array where the cards will be placed in the middle
    var potOfGold: [Card] = []
    
    //create the deck to be used for the game
    var gameDeck = Deck()
    
    var gameIsOngoing = true
    
    
    //initialize the indicators to be player 1 and 2
    init() {
        
        //assign offence and defence
        offence = player1
        defence = player2
        
        //run the play function
        play()
    }
    
    
    //deal out the cards
    mutating func giveInitialCardsToPlayers() {
        player1.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
        player2.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
    }
    
    //switch who is on offence
    mutating func switchWhoIsOnOffence() {
        //Switch the offence if it is player1
        if offence === player1 {
            offence = player2
            defence = player1
            // Switch the offence if it is player 2
        } else {
            offence = player1
            defence = player2
        }
    }
    
    mutating func gameIsOver(winnerIs: String) {
        gameIsOngoing = false
        print("The winner is \(winnerIs)!")
    }
    
    mutating func checkIfSomeoneHasLost() {
        if player1.cards.count <= 0 {
            gameIsOver(winnerIs: "player two")
        } else if player2.cards.count <= 0 {
            gameIsOver(winnerIs: "player one")
        }
    }
    
    //play the game
    func play() {
        
    }
    
}

