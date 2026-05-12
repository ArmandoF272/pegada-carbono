# Pegada de Carbono

Aplicação web para cálculo e acompanhamento da pegada de carbono pessoal, desenvolvida como projeto da disciplina **Engenharia de Software I** — Centro Universitário Farias Brito.

**Equipe:** Armando Farias, Laysa e João Vitor  
**Professor:** Helano Matos

## Funcionalidades

- Cálculo mensal de emissões por categoria: Transporte, Energia, Alimentação e Compras
- Histórico de cálculos com variação entre períodos
- Relatório com gráficos de evolução
- Dicas de redução de emissões filtradas por categoria
- Comparativo com a média brasileira (6,50 tCO₂e/ano) e meta do Acordo de Paris (2,30 tCO₂e/ano)

## Stack

- Ruby on Rails 8 + PostgreSQL
- Tailwind CSS + Chartkick + Chart.js
- Devise (autenticação)
- Docker + Docker Compose
- RSpec (testes)

## Rodando com Docker

```bash
docker compose up --build
docker compose exec web rails db:create db:migrate db:seed
```

Acesse: http://localhost:3000

## Rodando localmente

```bash
bundle install
rails db:create db:migrate db:seed
bin/dev
```

## Testes

```bash
bundle exec rspec
```

## Fatores de emissão utilizados

| Categoria | Fator |
|---|---|
| Carro (gasolina) | 0,21 kgCO₂/km |
| Ônibus / metrô | 0,089 kgCO₂/km |
| Voo doméstico | 255 kgCO₂/trecho |
| Energia elétrica (mix Brasil) | 0,10 kgCO₂/kWh |
| Carne bovina | 27 kgCO₂e/kg |

Fontes: SEEG / IPCC (contexto Brasil, 2023)
