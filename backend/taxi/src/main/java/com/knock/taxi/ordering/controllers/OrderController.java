package com.knock.taxi.ordering.controllers;

import java.sql.Date;
import java.util.List;

import com.knock.taxi.ordering.OrderingService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path="private/order", produces = MediaType.APPLICATION_JSON_VALUE)
public class OrderController {

    @Autowired
    OrderingService orderingService;

    @PutMapping("createOrder/{customerId}")
    public void CreateOrder(@PathVariable String customerId, Date time, String destination) {
        orderingService.CreateOrder(customerId, time, destination);
    }

    @GetMapping("getOrders/{customerId}")
    public List<?> GetOrders(@PathVariable String customerId){
        return orderingService.GetOrdersFor(customerId);
    }

}

