package com.knock.taxi;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;


@Configuration
@EnableMongoRepositories
public class MongoConfiguration{

    private com.mongodb.client.MongoClient mongoClient;
    private MongoDatabase mongoDatabase;
	
    @Bean
    public MongoClient mongoClient(){
        return this.mongoClient;
    }

    @Bean
    public MongoDatabase mongoDatabase(){
        return mongoDatabase;
    }

    public MongoConfiguration(@Value("${spring.data.mongodb.uri}") String uri, @Value("${spring.data.mongodb.database}") String databaseName) {
        this.mongoClient = MongoClients.create(uri);
        this.mongoDatabase = this.mongoClient.getDatabase(databaseName);
    }
}
