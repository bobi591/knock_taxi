//
//  OrderView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import SwiftUI

struct OrdersHistoryView: View {
    
    init(orders:Array<Order>) {
        self.orders = orders
    }
    
    private var orders:Array<Order>
    private var dateFormatter:DateFormatter = DateFormatter()
    
    @State private var searchDestination:String = ""
    private var foundOrders: [Order]{
        if(searchDestination.isEmpty){
            return orders
        }
        else{
            var foundOrders:Array<Order> = []
            for order in orders {
                if order.destination.contains(searchDestination){
                    foundOrders.append(order)
                }
            }
            return foundOrders
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(orders) {
                        order in
                        Text("\(order.destination) \(dateFormatter.string(from: order.time))")
                    }
                }.listStyle(.automatic)
                    .navigationTitle("Order History")
                Button("Order a ride?") {
                    
                }.buttonStyle(.bordered)
            }
        }
        .searchable(text: $searchDestination, prompt: "Search for previous destination")
    }
}

struct OrdersHistoryView_Previews: PreviewProvider {
    private static func getFakeOrders() -> Array<Order>{
        let order1:Order = Order.init(id: "1", customerId: "fake@mail.com", time: Date.now, status: OrderStatus.ACCEPTED, destination: "Fake city 31")
        
        let order2:Order = Order.init(id: "2", customerId: "fake@mail.com", time: Date.now, status: OrderStatus.COMPLETED, destination: "Fake location 83")
        
        let order3:Order = Order.init(id: "2", customerId: "fake@mail.com", time: Date.now, status: OrderStatus.TERMINATED, destination: "Fake location 44")
        
        return [order1, order2, order3]
        
    }
    static var previews: some View {
        Group {
            OrdersHistoryView(orders: self.getFakeOrders())
                .previewInterfaceOrientation(.portrait)
            OrdersHistoryView(orders: self.getFakeOrders())
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
