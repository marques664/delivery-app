package com.example.delivery.services;

import com.example.delivery.model.ItemPedido;
import com.example.delivery.model.Pedido;
import com.example.delivery.model.Produto;
import com.example.delivery.model.StatusPedido;
import com.example.delivery.repository.PedidoRepository;
import com.example.delivery.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PedidoService {

    @Autowired
    private PedidoRepository pedidoRepository;

    @Autowired
    private ProdutoRepository produtoRepository;

    public Pedido criarPedido(Pedido pedido) {

        //  define status inicial
        pedido.setStatus(StatusPedido.CRIADO);

        double total = 0;

        for (ItemPedido item : pedido.getItens()) {

            Produto produto = produtoRepository
                    .findById(item.getProduto().getId())
                    .orElseThrow();

            item.setProduto(produto);

            item.setPedido(pedido);

            total += produto.getPreco() * item.getQuantidade();
        }

        pedido.setTotal(total);

        return pedidoRepository.save(pedido);
    }

    public List<Pedido> listar() {
        return pedidoRepository.findAll();
    }

    public Pedido buscarPorId(Long id) {
        return pedidoRepository.findById(id).orElseThrow();
    }

    public Pedido atualizarStatus(Long id, StatusPedido status) {

        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow();

        pedido.setStatus(status);


        return pedidoRepository.save(pedido);
    }


}


