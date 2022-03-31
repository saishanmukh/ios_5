//
//  ViewController.swift
//  Garugu_WordGuess
//
//  Created by student on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var _imageView: UIImageView!
    
    
    var words = [["SWIFT", "Programming Language","0"],
              ["DOG", "Animal", "1"],
              ["BIKE", "Two wheeler", "2"],
              ["IPHONE", "Apple device", "3"],
            ["AIRPODS", "Apple pods", "4"]]
    
    var wordsGuessed = 0
    var wordsRemaining = 0
    var wordsMissed = 0
    let maxNumOfWrongGuesses = 10
    var tries = 0
    
    var count = 0
    var word = ""
    var lettersGuessed = ""
    
    
    @IBAction func guessLetterButtonPressed(_ sender: Any) {
        tries += 1
        //Get the text from the text field.
        guessCountLabel.text = "You have made \(tries) guesses"
        if tries < maxNumOfWrongGuesses{
        
        //Replace the guessed letter if the letter is part of the word.
        lettersGuessed = lettersGuessed + guessLetterField.text!
         var revealedWord = ""
        for l in word{
            if lettersGuessed.contains(l){
                revealedWord += "\(l)"
            }
            else{
                revealedWord += "_ "
            }
        }
        //Assigning the word to displaylabel after a guess
        userGuessLabel.text = revealedWord
        guessLetterField.text = ""
        
            if revealedWord == words[count][0] {
                hintLabel.text = "A game played"
                guessCountLabel.text = "You Won! It took \(tries) to \nguess the word!"
                _imageView.image = UIImage(named:words[count][2])
                
//                animate()
                count += 1
                wordsGuessed += 1
                
                tries = 0
                wordsGuessedLabel.text = "Total number of words guessed successfully : \(wordsGuessed)"
                wordsRemainingLabel.text = "Total number of words remaining in game :  \(5-count)"

                
                if 5-count == 0 {
                    count = 0
                    guessCountLabel.text = "You have tired all the words! \nRestart from the begining"
                    wordsGuessed = 0
                    wordsRemaining = 0
                    word = ""
                    wordsMissed = 0
                    
                }
             }
        
        }
        else{
            wordsMissed += 1
            wordsMissedLabel.text = "Total number of words guessed wrongly : \(wordsMissed)"
            guessCountLabel.text = "You are out of all guesses. Try again?"
            _imageView.image = UIImage(named:"6")
        }
    }

    @IBAction func playAgainButtonPressed(_ sender: Any) {
        lettersGuessed = ""
        tries = 0
        userGuessLabel.text = ""
        word = words[count][0]
        hintLabel.text = "Hint: "+words[count][1]
        guessCountLabel.text = "You have made \(tries) guesses"
        updateUnderscores()
    }
    
    
    
    @IBAction func guessLetterEntered(_ sender: UITextField) {
        //Read the data from the text field
        var textEnterd = guessLetterField.text!;
        //Consider only the last character by calling textEntered.last and trimming the white spaces.
        textEnterd = String(textEnterd.last ?? " ").trimmingCharacters(in: .whitespaces)
        guessLetterField.text = textEnterd
        
        //Check whether the entered text is empty or not to enable check button.
//        if textEnterd.isEmpty{
//            guessLetterButton.isEnabled = false
//        }
//        else{
//            guessLetterButton.isEnabled = true
//        }
    }
    
    func updateUnderscores() {
        for _ in word{
            userGuessLabel.text! += "- "
        }
    }
    func animate(){
        let originalImageFrame = _imageView.frame
        let imageWidthShrink: CGFloat = 20
        let imageHeightShrink: CGFloat = 20
        let smallerImageFrame = CGRect(
            x: _imageView.frame.origin.x + imageWidthShrink,
            y: _imageView.frame.origin.y + imageHeightShrink,
            width: _imageView.frame.width - (imageWidthShrink * 2),
            height: _imageView.frame.height - (imageHeightShrink * 2))
        
        _imageView.frame = smallerImageFrame
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: [.curveEaseIn], animations: {
            self._imageView.frame = originalImageFrame
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsGuessedLabel.text = wordsGuessedLabel.text! + " \(wordsGuessed)"
        wordsMissedLabel.text = wordsMissedLabel.text! + " \(wordsMissed)"
        wordsRemainingLabel.text = wordsRemainingLabel.text! + "\(5-(wordsGuessed+wordsMissed))"
        totalWordsLabel.text = totalWordsLabel.text! + " 5"
//        guessLetterButton.isEnabled = false
        word = words[count][0]
        hintLabel.text = "Hint: "+words[count][1]
        guessCountLabel.text = "You have made \(tries) guesses"
        updateUnderscores()
        
        // Do any additional setup after loading the view.
    }


}

