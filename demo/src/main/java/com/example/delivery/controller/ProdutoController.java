package com.example.delivery.controller;

import com.example.delivery.services.ProdutoService;
import com.example.delivery.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService service;

    @PostMapping
    public Produto criar(@RequestBody Produto p) {
        return service.salvar(p);
    }

    @GetMapping
    public List<Produto> listar() {
        return service.listar();
    }

    @GetMapping("/restaurante/{id}")
    public List<Produto> listarPorRestaurante(@PathVariable Long id) {
        return service.listarPorRestaurante(id);
    }
}