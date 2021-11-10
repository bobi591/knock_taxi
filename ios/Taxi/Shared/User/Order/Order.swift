//
//  Order.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import Foundation
public struct Order : Codable, Identifiable{
    public var id:String;
    public var customerId:String;
    public var time:Date;
    public var status:OrderStatus;
    public var destination:String;
}

public enum OrderStatus : Codable {
    case CREATED
    case QUEUED
    case ACCEPTED
    case TERMINATED
    case COMPLETED
}
