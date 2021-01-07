package be.svanpe.api.webshopfront;

import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.ui.Model;
import org.webjars.NotFoundException;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class OrderControllerTest {

    @Mock
    private OrderClient orderRepo;
    @Mock
    private Model model;
    @InjectMocks
    private OrderController orderController;


    @Test
    public void orderTesting() {
        List<Order> order = new ArrayList<>();

        when(orderRepo.getOrdersByCustomerRef("Ashmi")).thenReturn(order);

        orderController.orders("Ashmi", model);
        verify(model).addAttribute(eq("version"), any());
        verify(model).addAttribute(eq("orders"), eq(order));
    }

    @Test
    public void orderTestingWithException() {
        when(orderRepo.getOrdersByCustomerRef("Ashmi")).thenThrow(NotFoundException.class);

        Assertions.assertThrows(NotFoundException.class, () -> orderController.orders("Ashmi", model));
        verify(model).addAttribute(eq("version"), any());
    }
}
