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
    
    //create a variable to track if game is over
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
    
    //    mutating func giveInitialCardsToPlayers() {
    //        player1.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
    //        player2.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
    //    }
    
    mutating func createAndRandomlyDealCards() {
        //create a full deck array (empty) to add cards to
        var fullDeck: [Card] = []
        
        //generate a full deck of cards with loops and add them to the full deck
        for generatedSuit in 1...4 {
            for generatedValue in 2...14 {
                fullDeck.append(Card(suit: Suit(rawValue: generatedSuit)!, rank: Rank(rawValue: generatedValue)!))
            }
        }
        
        //shuffle the deck and divide up the cards into each player's hand
        for i in 0...51 {
            
            //get the index of a random card in the full deck
            let randomIndex = Int.random(in: 0...(fullDeck.count - 1))
            //get a reference to what card will be given to a player
            let cardToMove: Card = fullDeck[randomIndex]
            
            //decide which player to give the card to
            if i % 2 == 0 {
                player1.cards.append(cardToMove)
            } else {
                player2.cards.append(cardToMove)
            }
            
            //remove the card from the full deck
            fullDeck.remove(at: randomIndex)
            
        }
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
    
    //create a function to announce the winners
    mutating func gameIsOver(winnerIs: String) {
        gameIsOngoing = false
        print("The winner is \(winnerIs)!")
    }
    
    //create a function to see if someone has lost
    mutating func checkIfSomeoneHasLost() {
        if gameIsOngoing {
            //Check to see if the player's cards are 0
            if player1.cards.count <= 1 {
                gameIsOver(winnerIs: "player two")
            } else if player2.cards.count <= 1 {
                gameIsOver(winnerIs: "player one")
            }
        }
    }
    
    //Draw a card from the hand and add it to the pot of gold
    mutating func playCard(player: Hand) {
        let cardToAdd = player.dealTopCard()
        potOfGold.append(cardToAdd!)
    }
    
    //Makes the offensive player play his card and pass the turn
    mutating func playHand() {
        
        checkIfSomeoneHasLost()
        
        let cardThatIsPlayed = offence.topCard!
        playCard(player: offence)
        //if the card played is a face card, do the showdown
        if cardThatIsPlayed.rank.rank >= 11 {
            print("It a showdown.")
            initiateAShowdown(cardToDefendAgainst: cardThatIsPlayed)
            //if there is no showdown, change who is on offence
        } else {
            switchWhoIsOnOffence()
        }
        
        if gameIsOngoing {
            print("The offensive player played a \(cardThatIsPlayed.simpleDescription())")
            printHandStats()
        }
    }
    
    
    
    //function to perform a showdown
    mutating func initiateAShowdown(cardToDefendAgainst: Card) {
        
        checkIfSomeoneHasLost()
        
        //how many chances the defence gets
        let numberOfChances = cardToDefendAgainst.rank.rank - 10
        
        //defence plays until they get a face card
        for _ in 1...numberOfChances {
            checkIfSomeoneHasLost()
            if gameIsOngoing == false {
                return
            }
            let attemptedDefendingCard = defence.topCard!
            playCard(player: defence)
            //if they play a face card, do another showdown after switching offence
            if attemptedDefendingCard.rank.rank >= 11 {
                
                switchWhoIsOnOffence()
                print("It 'nother showdown.")
                initiateAShowdown(cardToDefendAgainst: attemptedDefendingCard)
                return
            }
            
        }
        
        //if they didn't get a face, offence gets all cards and offence swaps
        offence.cards.append(contentsOf: potOfGold)
        potOfGold.removeAll()
        switchWhoIsOnOffence()
        
    }
    
    //play the game
    mutating func play() {
        createAndRandomlyDealCards()
        while gameIsOngoing {
            playHand()
        }
    }
    
    func printHandStats() {
        if offence === player1 {
            print("Player one is on offence")
        } else {
            print("Player two is on offence")
        }
        
        print("player one has \(player1.cards.count) cards")
        print("player two has \(player2.cards.count) cards")
        
        print("==================================")
        
    }
    
}

var ultimateBeg = BeggarThyNeigbourGame()
ultimateBeg.play()

