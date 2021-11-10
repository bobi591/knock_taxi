package com.knock.taxi.ordering.dto;

import java.util.Date;

import com.knock.taxi.ordering.enums.OrderStatus;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Order {

	public Order(String customerId, Date time, String destination) {
		this.customerId = customerId;
		this.time = time;
		this.status = OrderStatus.CREATED;
		this.destination = destination;
	}

	@Id
	private String id;
	private String customerId;
	private Date time;
	private OrderStatus status;
	private String destination;

	public String getId() {
		return id;
	}

	public String getCustomerId() {
		return customerId;
	}

	public Date getTime() {
		return time;
	}

	public OrderStatus getStatus() {
		return status;
	}

	public void setStatus(OrderStatus status) {
		this.status = status;
	}

	public String getDestination() {
		
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
}
