package com.knock.taxi.customer;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Customer {
    @Id
    private String id;
    private String email;
    private String lastLocation;

    public Customer(String email){
        this.email = email;
        this.lastLocation = "";
    }

	public String getId() {
        return id;
    }
    
    public String getEmail() {
        return email;
    }

    public String getLastLocation() {
        return lastLocation;
    }

    public void setLastLocation(String lastLocation) {
        this.lastLocation = lastLocation;
    }
}
