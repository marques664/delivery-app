# 📊 Arquitetura da Integração

## Fluxo de Dados

```
┌─────────────────────────────────────────────────────────────────┐
│                    CLIENTE (FLUTTER APP)                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─ lib/features/home/                                           │
│  │   └─ pages/home_page.dart                                     │
│  │       ├─ Exibe lista de restaurantes                          │
│  │       └─ Usa: restaurantServiceProvider                       │
│  │                                                                │
│  ├─ lib/shared/providers/                                        │
│  │   ├─ dio_provider.dart (HTTP Client + Logging)               │
│  │   └─ service_providers.dart (Serviços)                       │
│  │                                                                │
│  ├─ lib/shared/services/                                         │
│  │   ├─ restaurant_service.dart (GET /restaurantes)             │
│  │   ├─ product_service.dart (GET /produtos)                    │
│  │   └─ order_service.dart (POST /pedidos)                      │
│  │                                                                │
│  └─ lib/core/constants/api_constants.dart                        │
│      └─ baseUrl = 'http://localhost:8080'                       │
│                                                                   │
└────────────────────────────┬──────────────────────────────────────┘
                             │
                    HTTP/REST │ (Dio Package)
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    SERVIDOR (SPRING BOOT)                        │
│                   http://localhost:8080                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─ src/main/java/com/example/delivery/controller/              │
│  │   ├─ RestaurantController.java                               │
│  │   │   GET  /restaurantes          → listar()                 │
│  │   │   POST /restaurantes          → criar()                  │
│  │   │   GET  /restaurantes/{id}     → buscarPorId()            │
│  │   │                                                            │
│  │   ├─ ProdutoController.java                                  │
│  │   │   GET  /produtos              → listar()                 │
│  │   │   GET  /produtos/restaurante/{id} → listarPorRestaurante │
│  │   │   POST /produtos              → criar()                  │
│  │   │                                                            │
│  │   └─ PedidoController.java                                   │
│  │       GET  /pedidos               → listar()                 │
│  │       POST /pedidos               → criarPedido()            │
│  │       PUT  /pedidos/{id}/status   → atualizarStatus()        │
│  │                                                                │
│  ├─ src/main/java/com/example/delivery/services/                │
│  │   ├─ ProdutoService.java                                     │
│  │   └─ PedidoService.java                                      │
│  │                                                                │
│  ├─ src/main/java/com/example/delivery/model/                   │
│  │   ├─ Restaurante.java (ID, nome, endereco)                  │
│  │   ├─ Produto.java (ID, nome, preco, restaurante)            │
│  │   ├─ Pedido.java (ID, status, total, restaurante, itens)    │
│  │   └─ ItemPedido.java (ID, produto, quantidade, pedido)      │
│  │                                                                │
│  ├─ src/main/java/com/example/delivery/config/                  │
│  │   └─ CorsConfig.java ← CONFIGURADO PARA ACEITAR MULTI-IP    │
│  │                                                                │
│  ├─ src/main/resources/                                          │
│  │   └─ application.properties ← NOVO! Configurações H2        │
│  │                                                                │
│  └─ H2 Database (Em memória)                                     │
│      ├─ RESTAURANTE                                              │
│      ├─ PRODUTO                                                  │
│      ├─ PEDIDO                                                   │
│      └─ ITEM_PEDIDO                                              │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Fluxo de uma Requisição

### Exemplo: Listar Restaurantes

```
1. Usuario toca em "Home" no app Flutter
   ↓
2. HomePageUI chama: restaurantServiceProvider
   ↓
3. RestaurantService.getRestaurants() é executado
   ↓
4. Dio faz requisição HTTP:
   ┌────────────────────────────────────┐
   │ GET http://localhost:8080/restaurantes
   │ Headers:
   │   Content-Type: application/json
   └────────────────────────────────────┘
   ↓
5. LoggingInterceptor intercepta e printa:
   ═════════════════════════════════════════
   [Dio] 🌐 REQUEST
   [Dio] URL: http://localhost:8080/restaurantes
   [Dio] Method: GET
   ═════════════════════════════════════════
   ↓
6. Spring Boot recebe em RestaurantController
   @GetMapping
   public List<Restaurante> listar() {
       return repo.findAll();
   }
   ↓
7. Hibernatica faz query no H2:
   SELECT * FROM RESTAURANTE
   ↓
8. Controller retorna JSON:
   [
     {
       "id": 1,
       "nome": "Pizza do João",
       "endereco": "Rua das Flores, 123"
     }
   ]
   ↓
9. LoggingInterceptor intercepta response:
   ═════════════════════════════════════════
   [Dio] ✅ RESPONSE
   [Dio] Status: 200
   [Dio] Path: /restaurantes
   [Dio] Data: [...]
   ═════════════════════════════════════════
   ↓
10. RestaurantService deserializa JSON → List<Restaurant>
    ↓
11. Riverpod provider fornece dados para UI
    ↓
12. UI reconstruída mostrando: "Pizza do João"
```

---

## 📁 Estrutura de Pastas

```
delivery-app/
├── INTEGRACAO_GUIA.md          ← LEIA ISTO PRIMEIRO
├── QUICK_FIX.md                ← TL;DR
│
├── delivery_app_backend/       
│   ├── build.gradle
│   ├── src/main/
│   │   ├── java/com/example/delivery/
│   │   │   ├── DeliveryApplication.java (Main)
│   │   │   ├── controller/
│   │   │   │   ├── RestaurantController.java   [ATUALIZADO]
│   │   │   │   ├── ProdutoController.java
│   │   │   │   └── PedidoController.java
│   │   │   ├── model/
│   │   │   │   ├── Restaurante.java
│   │   │   │   ├── Produto.java
│   │   │   │   └── Pedido.java
│   │   │   ├── repository/
│   │   │   ├── services/
│   │   │   └── config/
│   │   │       └── CorsConfig.java  [ATUALIZADO]
│   │   └── resources/
│   │       └── application.properties  [NOVO!]
│   │
│   └── gradlew.bat
│
└── mobile/delivery_app_frontend/
    ├── pubspec.yaml
    ├── lib/
    │   ├── main.dart
    │   ├── core/
    │   │   └── constants/
    │   │       └── api_constants.dart  [ATUALIZADO]
    │   ├── shared/
    │   │   ├── providers/
    │   │   │   ├── dio_provider.dart  [ATUALIZADO]
    │   │   │   └── service_providers.dart
    │   │   ├── services/
    │   │   │   ├── restaurant_service.dart
    │   │   │   ├── product_service.dart
    │   │   │   └── order_service.dart
    │   │   └── models/
    │   │       ├── restaurant.dart
    │   │       ├── product.dart
    │   │       └── order.dart
    │   └── features/
    │       ├── home/
    │       ├── restaurant_detail/
    │       └── order_tracking/
    │
    └── android/, ios/, web/, etc.
```

---

## 📝 Resumo das Mudanças Feitas

### ✅ Arquivo: `application.properties` [CRIADO]
- Configuração do banco H2
- Logging do Hibernate
- Porta 8080
- Serialização JSON

### ✅ Arquivo: `CorsConfig.java` [ATUALIZADO]
- Adicionado suporte para múltiplos IPs locais
- Aceita requisições de 192.168.x.x
- Adicionado header PATCH

### ✅ Arquivo: `RestaurantController.java` [ATUALIZADO]
- Adicionado endpoint: `GET /restaurantes/{id}`

### ✅ Arquivo: `api_constants.dart` [ATUALIZADO]
- Comentários explicando como usar em diferentes ambientes
- Facilita mudança de localhost para IP

### ✅ Arquivo: `dio_provider.dart` [ATUALIZADO]
- Melhor logging de requisições
- Formatação visual das requisições/respostas
- Melhor identificação de erros

---

## 🎯 Próximas Etapas

1. **Iniciar Backend:** `./gradlew bootRun`
2. **Configurar Frontend:** Editar `api_constants.dart` se necessário
3. **Instalar dependências:** `flutter pub get`
4. **Executar app:** `flutter run`
5. **Testar:** Criar e listar restaurantes na UI

---

## 🔗 Endpoints Disponíveis

### Restaurantes
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/restaurantes` | Listar todos |
| GET | `/restaurantes/{id}` | Um específico |
| POST | `/restaurantes` | Criar novo |

### Produtos
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/produtos` | Listar todos |
| GET | `/produtos/{id}` | Um específico |
| GET | `/produtos/restaurante/{id}` | Por restaurante |
| POST | `/produtos` | Criar novo |

### Pedidos
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/pedidos` | Listar todos |
| GET | `/pedidos/{id}` | Um específico |
| POST | `/pedidos` | Criar novo |
| PUT | `/pedidos/{id}/status` | Atualizar status |

---

**Status:** ✅ Pronto para integração!

