//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/02/01.
//

import Foundation

/*
 CodingKey：A type that can be used as a key for encoding and decoding.
 */
public enum CodingKeys: String, CodingKey {
    // for Repository
    case id
    case name
    case fullName = "full_name"
    case ownerss
    // for SearchResponse<Item>
    case totalCount = "total_count"
    case items
}
