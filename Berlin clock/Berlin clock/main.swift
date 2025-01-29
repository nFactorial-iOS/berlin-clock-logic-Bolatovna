//
//  main.swift
//  Berlin clock
//
//  Created by Bayan Serikbay on 1/29/25.
//

import Foundation

func berlinClockTime(_ time: String) -> [String]? {
    // Разбиваем строку на три части: часы, минуты, секунды
    let parts = time.split(separator: ":").compactMap {
        Int($0)
    }
    
    // Проверяем, что введены три числа, создала лимиты
    guard parts.count == 3,
            parts[0] < 24,
            parts[1] < 60,
            parts[2] < 60
    else {
        return nil
    }
    let (h, m, s) = (parts[0], parts[1], parts[2])
    
    //  Y при чётных,O при нечётных (if - else)
    let topLamp = s % 2 == 0 ? "Y" : "O"

  
    // Часы - 1, каждая лампа 5 часов (4 лампы)
    let fiveHourLamps = String(repeating: "R", count: h / 5) + String(repeating: "O", count: 4 - h / 5)
    // Часы - 2 каждая лампа 1 час (4 лампы)
    let oneHourLamps = String(repeating: "R", count: h % 5) + String(repeating: "O", count: 4 - h % 5)

  
    // Минуты - 1 каждая лампа 5 минут (11 ламп)
    // YYRYYRYYRYY
    var fiveMinuteLamps = ""
        for i in 0..<11 {
            if (i + 1) % 3 == 0 { // every 3'rd: (R)
                fiveMinuteLamps += i < m / 5 ? "R" : "O"
            } else { // other (Y)
                fiveMinuteLamps += i < m / 5 ? "Y" : "O"
            }
        }
    // Минуты -2 каждая лампа 1 минута (4 лампы)
    let oneMinuteLamps = String(repeating: "Y", count: m % 5) + String(repeating: "O", count: 4 - m % 5)
    
    return [topLamp, fiveHourLamps, oneHourLamps, fiveMinuteLamps, oneMinuteLamps]
}

// Цикл, принимает инпут юзера
while true {
    print("Enter time (HH:MM:SS) or '1' to exit: ", terminator: "")
    
    guard let input = readLine(), !input.isEmpty else {
        print("Invalid input. Please enter a valid time format.")
        continue
    }
    
    if input == "1" { break }

    guard let berlinTime = berlinClockTime(input) else {
        print("Invalid format. Try again.")
        continue
    }

    berlinTime.forEach { print($0) }
}
