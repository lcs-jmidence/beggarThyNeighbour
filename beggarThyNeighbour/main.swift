//
//  main.swift
//  beggarThyNeighbour
//
//  Created by Midence Rosario, Julio on 2020-02-20.
//  Copyright © 2020 Julio Midence. All rights reserved.
//

import Foundation

//player structure
class Player {
    var name : String
    var hand : Hand
    var numberOfPotsTaken = 0
    var numberOfGamesWon = 0
    
    init(playerName: String) {
        self.name = playerName
        
    }
    //reset the statistics for the player
    func resetHandStats() {
        numberOfPotsTaken = 0
    }
}

//actual structure for the game
struct beggarThyNeigbourGame {
    
    var player1: Player
    var player2: Player
    
    var gameDeck = Deck()
    
    mutating func giveInitialCardsToPlayers() {
        player1.hand.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
        player2.hand.cards.append(contentsOf: gameDeck.randomlyDealOut(thisManyCards: 26)!)
    }
    
    func switchWhoIsOnOffence() {
        
    }
    
}
