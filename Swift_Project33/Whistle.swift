//
//  Whistle.swift
//  Swift_Project33
//
//  Created by Alex 6.1 on 10/3/21.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
