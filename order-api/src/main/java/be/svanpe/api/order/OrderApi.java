package be.svanpe.api.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping("orders")
public class OrderApi {


   @Autowired
   OrderService orderService;

   @PostMapping
    public Long postOrder(@RequestBody Order order){

       Order cOrder = orderService.createOrder(order);

       System.out.println("order created " + cOrder.getId());

       return cOrder.getId();

    }

    @GetMapping
    public List<Order> getOrders(@RequestParam(name = "customerReference") String customerReference){

       return orderService.getOrdersByCustomerReference(customerReference);
    }
}
