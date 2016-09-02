//
//  EventSubscriber.swift
//  PasscodeLock
//
//  Created by Mark Hudnall on 9/1/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation

class EventSubscriber {
    weak var target: AnyObject?
    let selector: Selector
    let eventName: String
    let object: AnyObject?
    
    let notificationCenter: NSNotificationCenter
    
    init(target: AnyObject,
         selector: Selector,
         eventName: String,
         object: AnyObject? = nil,
         notificationCenter: NSNotificationCenter = NSNotificationCenter.defaultCenter()) {
        self.target = target
        self.selector = selector
        self.eventName = eventName
        self.object = object
        self.notificationCenter = notificationCenter
    }
    
    func unsubscribe() {
        self.notificationCenter.removeObserver(self)
    }
    
    func subscribe() {
        self.notificationCenter.addObserver(self, selector: #selector(handleEvent), name: self.eventName, object: self.object)
    }
    
    @objc func handleEvent(notification: NSNotification) {
        target?.performSelector(self.selector, withObject: notification)
    }
}
