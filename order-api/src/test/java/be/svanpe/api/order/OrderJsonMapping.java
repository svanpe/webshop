package be.svanpe.api.order;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import net.minidev.json.parser.JSONParser;
import org.junit.jupiter.api.Test;
import org.springframework.util.Assert;

import java.io.File;
import java.io.FileReader;

public class OrderJsonMapping {

    @Test
    public void testMappingWithList() throws Exception{

        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        FileReader jsonFile = new FileReader(new File(this.getClass().getClassLoader().getResource("json/order.json").getFile()));

        assert(jsonFile!=null);
        Order order  = mapper.readValue(jsonFile, Order.class);

        assert(order!=null);

    }
}
