package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

public class testController {
    @RestController
    public class TestController {

        @GetMapping("/test")
        public String teste() {
            return "API funcionando!";
        }
    }
}
