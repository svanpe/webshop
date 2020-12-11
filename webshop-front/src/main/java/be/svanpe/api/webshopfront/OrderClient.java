package be.svanpe.api.webshopfront;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Component
public class OrderClient {

    @Value("${orderservice.url}")
    private String orderServiceUrl;

    RestTemplate restTemplate;

    public OrderClient(RestTemplateBuilder restTemplateBuilder){
        restTemplate = restTemplateBuilder.build();
    }

    public List<Order> getOrdersByCustomerRef(String cusotmerRef){
        Order[] orders = restTemplate.getForObject(orderServiceUrl + "/orders?customerReference="+ cusotmerRef, Order[].class);

        return Arrays.asList(orders);
    }

}
