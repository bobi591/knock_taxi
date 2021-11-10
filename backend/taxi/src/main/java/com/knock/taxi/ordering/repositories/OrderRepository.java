package com.knock.taxi.ordering.repositories;

import java.util.List;

import com.knock.taxi.ordering.dto.Order;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface OrderRepository extends MongoRepository<Order,String> {
    public List<Order> findByCustomerId(String customerId);
}
