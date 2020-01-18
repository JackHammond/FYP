package com.example.rdservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class RDServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(RDServiceApplication.class, args);
	}

}
