package com.example.delivery.services;

import com.example.delivery.model.ItemPedido;
import com.example.delivery.model.Pedido;
import com.example.delivery.repository.PedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PedidoService {

    @Autowired
    private PedidoRepository pedidoRepository;

    public Pedido criarPedido(Pedido pedido) {

        //  define status inicial
        pedido.setStatus("CRIADO");

        //  liga cada item ao pedido
        for (ItemPedido item : pedido.getItens()) {
            item.setPedido(pedido);
        }

        return pedidoRepository.save(pedido);
    }

    public List<Pedido> listar() {
        return pedidoRepository.findAll();
    }

    public Pedido buscarPorId(Long id) {
        return pedidoRepository.findById(id).orElseThrow();
    }
}
