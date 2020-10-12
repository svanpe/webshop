package be.svanpe.api.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class OrderService {

    @Autowired
    OrderRepository orderRepository;

    public Order createOrder(Order order){
        return orderRepository.save(order);
    }

    public List<Order> getOrdersByCustomerReference(String customerReference){
        return orderRepository.findByCustomerReference(customerReference);
    }
}
