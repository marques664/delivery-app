package com.example.delivery.controller;

import com.example.delivery.model.Restaurante;
import com.example.delivery.repository.RestauranteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurantes")
public class testController {

    @Autowired
    private RestauranteRepository repo;

    // GET → listar restaurantes
    @GetMapping
    public List<Restaurante> listar() {
        return repo.findAll();
    }

    // POST → criar restaurante
    @PostMapping
    public Restaurante criar(@RequestBody Restaurante r) {
        return repo.save(r);
    }
}