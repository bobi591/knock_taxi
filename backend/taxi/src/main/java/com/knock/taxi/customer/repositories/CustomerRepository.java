package com.knock.taxi.customer.repositories;

import org.springframework.stereotype.Repository;
import com.knock.taxi.customer.Customer;
import org.springframework.data.mongodb.repository.MongoRepository;

@Repository
public interface CustomerRepository extends MongoRepository<Customer,String>{
    
}
