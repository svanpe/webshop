package be.svanpe.api.order;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.io.File;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


import static org.hamcrest.Matchers.containsString;
import static org.mockito.ArgumentMatchers.contains;
import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class OrderAPIClientTest {

    @Autowired
    private MockMvc mockMvc;


    @Test
    public void shouldReturnID() throws Exception {
        this.mockMvc.perform(post("/orders")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(getPostJsonSample()))
                            .andDo(print())
                            .andExpect(status().isOk());
    }
    @Test
    public void shouldReturnDefaultMessage() throws Exception {

        this.mockMvc.perform(post("/orders")
                .contentType(MediaType.APPLICATION_JSON)
                .content(getPostJsonSample()))
                .andDo(print())
                .andExpect(status().isOk());


        this.mockMvc.perform(get("/orders?customerReference=ABX777"))
                                .andDo(print())
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$..*.customerReference", Matchers.hasItem("ABX777")));

    }

    private String getPostJsonSample() throws Exception{

        URL url = getClass().getResource("/json/order.json");
        String contents = new String(Files.readAllBytes(Paths.get(url.toURI())));
        return contents;

    }
}
