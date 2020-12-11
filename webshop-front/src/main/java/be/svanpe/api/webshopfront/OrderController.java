package be.svanpe.api.webshopfront;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OrderController {

    @Autowired
    OrderClient orderRepo;

    @Value("${application.version}")
    private String version;

    @GetMapping("/orders")
    public String orders(@RequestParam(name="customer", required=false) String customerRef, Model model){

        model.addAttribute("version",version);
        model.addAttribute("orders",orderRepo.getOrdersByCustomerRef(customerRef));

        return "orders";
    }
}
