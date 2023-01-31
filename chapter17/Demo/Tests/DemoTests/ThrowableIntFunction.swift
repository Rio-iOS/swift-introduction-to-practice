//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

@testable import Demo


func throwableIntFunction(throwsError: Bool) throws -> Int {
    if throwsError {
        throw SomeError()
    }
    
    return 7
}
