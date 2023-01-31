//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

func throwableFunction(throwsError: Bool) throws {
    if throwsError {
        throw SomeError()
    }
}
