package com.example.delivery.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                // Permite requisiçõe de múltiplas origens
                .allowedOrigins(
                    "http://localhost:*",           // Desenvolvimento local
                    "http://127.0.0.1:*",           // Localhost alternativo
                    "http://192.168.0.*:*",         // Rede local
                    "http://192.168.1.*:*"          // Rede local alternativa
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}