package com.knock.taxi.customer.repositories;

import com.knock.taxi.customer.Order;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface OrderRepository extends MongoRepository<Order,String>{

}
