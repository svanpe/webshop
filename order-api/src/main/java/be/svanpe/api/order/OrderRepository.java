package be.svanpe.api.order;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderRepository extends CrudRepository<Order, Long> {

    List<Order> findByCustomerReference(String customerReference);
}
