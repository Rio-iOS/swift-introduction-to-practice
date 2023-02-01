//
//  Repository.swift
//  
//
//  Created by 藤門莉生 on 2023/02/01.
//

/*
 JSONキーのうち、full_nameは、Repository型のプロパティ名fullNameと一致しない
 このようなケースでは、列挙型のCodingKeys型をネスト型として定義し、「ケース名」と「ローバリュー」によって
 プロパティ名とJSONキーの対応関係を記述する
 */
public struct Repository: Decodable {
    public var id: Int
    public var name: String
    public var fullName: String
    public var owner: User // User型もDecodableプロトコルに準拠している必要がある
}
