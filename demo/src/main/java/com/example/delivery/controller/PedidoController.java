package com.example.delivery.controller;

import com.example.delivery.model.Pedido;
import com.example.delivery.services.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pedidos")
public class PedidoController {

    @Autowired
    private PedidoService service;

    // Criar pedido
    @PostMapping
    public Pedido criar(@RequestBody Pedido pedido) {
        return service.criarPedido(pedido);
    }

    // Listar pedidos
    @GetMapping
    public List<Pedido> listar() {
        return service.listar();
    }

    // Buscar por ID
    @GetMapping("/{id}")
    public Pedido buscar(@PathVariable Long id) {
        return service.buscarPorId(id);
    }
}