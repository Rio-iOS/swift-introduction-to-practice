//
//  GetIntAsync.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import Dispatch

func getIntAsync(completion: @escaping (Int) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        completion(4)
    }
}
