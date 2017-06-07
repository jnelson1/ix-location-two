//
//  profileChangeDelegate.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/7/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation

protocol ProfileChangeDelegate {
    func didSaveProfileChange(name: String)
    func didCancelProfileChange()
}
