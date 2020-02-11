//
//  DataProvider.swift
//  IQ69
//
//  Created by HuuNghia on 2/6/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import Foundation
import UIKit

public class DataProvider {
    
    private static var _questionBus:QuestionBussiness = QuestionBussiness()
    public static var questionBus:QuestionBussiness {
        get {
            return _questionBus
        }
    }
    
    private static var _userBus:UserBussiness = UserBussiness()
    public static var userBus:UserBussiness {
        get {
            return _userBus
        }
    }
    
}
