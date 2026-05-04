package com.example.delivery.repository;

import com.example.delivery.model.Produto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {

    // importante pra depois
    List<Produto> findByRestauranteId(Long restauranteId);
}
