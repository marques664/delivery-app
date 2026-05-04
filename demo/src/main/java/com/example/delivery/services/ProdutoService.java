package com.example.delivery.services;

import com.example.delivery.model.Produto;
import com.example.delivery.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProdutoService {

    @Autowired
    private ProdutoRepository repo;

    public Produto salvar(Produto p) {
        return repo.save(p);
    }

    public List<Produto> listar() {
        return repo.findAll();
    }

    public List<Produto> listarPorRestaurante(Long restauranteId) {
        return repo.findByRestauranteId(restauranteId);
    }
}