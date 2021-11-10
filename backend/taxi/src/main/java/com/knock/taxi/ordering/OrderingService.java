package com.knock.taxi.ordering;

import java.sql.Date;
import java.util.List;

import com.knock.taxi.context.AbstractKnockContext;
import com.knock.taxi.context.ContextResult;
import com.knock.taxi.context.ContextStatus;
import com.knock.taxi.ordering.dto.Order;
import com.knock.taxi.ordering.enums.OrderStatus;
import com.knock.taxi.ordering.repositories.OrderRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderingService extends AbstractKnockContext {

    @Autowired
    OrderRepository orderRepository;

    public void CreateOrder(String customerId, Date time, String destination){
        if(isNoOrderActiveForCustomer(customerId)){
            orderRepository.insert(new Order(customerId, time, destination));
            setResult(new ContextResult(null, ContextStatus.SUCCESS));
            return;
        }
        setResult(new ContextResult(null, ContextStatus.FAIL));
    }

    public List<Order> GetOrdersFor(String customerId){
        List<Order> orders = orderRepository.findByCustomerId(customerId);
        setResult(new ContextResult(null, ContextStatus.SUCCESS));
        return orders;
    }

    private boolean isNoOrderActiveForCustomer(String customerId) {
        List<Order> customerOrders = orderRepository.findByCustomerId(customerId);
        for(var order : customerOrders){
            if(order.getStatus() != OrderStatus.COMPLETED){
                return false;
            }
        }
        return true;
    }
}
