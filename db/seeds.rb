puts "Criando dicas de redução..."

Tip.delete_all

tips_data = [
  # Transporte
  { category: "Transporte", text: "Use bicicleta 2x por semana — substituir trajetos curtos de carro pode reduzir 180 kg de CO₂/ano.", impact_tco2_year: 0.18, difficulty: "Fácil" },
  { category: "Transporte", text: "Combine viagens com colegas (carona solidária) ao ir ao trabalho.", impact_tco2_year: 0.09, difficulty: "Fácil" },
  { category: "Transporte", text: "Use transporte público no lugar do carro em 3 dias por semana.", impact_tco2_year: 0.42, difficulty: "Médio" },
  { category: "Transporte", text: "Evite voos domésticos e prefira trem ou ônibus quando possível.", impact_tco2_year: 0.85, difficulty: "Difícil" },
  { category: "Transporte", text: "Adote a condução econômica (ecodriving): acelere suavemente e mantenha velocidade constante.", impact_tco2_year: 0.15, difficulty: "Fácil" },

  # Energia
  { category: "Energia", text: "Troque lâmpadas incandescentes por LED — economia de ~86% de energia em iluminação.", impact_tco2_year: 0.08, difficulty: "Fácil" },
  { category: "Energia", text: "Ajuste o ar-condicionado para 23 °C e evite deixá-lo ligado com janelas abertas.", impact_tco2_year: 0.06, difficulty: "Fácil" },
  { category: "Energia", text: "Instale painel solar fotovoltaico para reduzir o consumo da rede elétrica.", impact_tco2_year: 1.20, difficulty: "Difícil" },
  { category: "Energia", text: "Desligue aparelhos em modo standby — TV, carregadores e microondas consomem até 10% a mais.", impact_tco2_year: 0.04, difficulty: "Fácil" },
  { category: "Energia", text: "Use chuveiro elétrico no inverno apenas quando necessário — o gás é mais eficiente.", impact_tco2_year: 0.10, difficulty: "Médio" },

  # Alimentação
  { category: "Alimentação", text: "Reduza o consumo de carne vermelha para 2x por semana — impacto enorme no carbono alimentar.", impact_tco2_year: 0.42, difficulty: "Médio" },
  { category: "Alimentação", text: "Inclua 1 dia vegetariano por semana na sua rotina alimentar.", impact_tco2_year: 0.20, difficulty: "Fácil" },
  { category: "Alimentação", text: "Prefira alimentos da estação e de produtores locais — menos transporte, menos emissão.", impact_tco2_year: 0.15, difficulty: "Fácil" },
  { category: "Alimentação", text: "Reduza o desperdício de alimentos: planeje compras e use sobras.", impact_tco2_year: 0.30, difficulty: "Médio" },
  { category: "Alimentação", text: "Substitua proteína animal por leguminosas (feijão, lentilha) em algumas refeições.", impact_tco2_year: 0.35, difficulty: "Fácil" },

  # Compras
  { category: "Compras", text: "Compre roupas de segunda mão ou em brechós antes de comprar novas.", impact_tco2_year: 0.12, difficulty: "Médio" },
  { category: "Compras", text: "Repare eletrônicos em vez de substituí-los ao primeiro problema.", impact_tco2_year: 0.25, difficulty: "Médio" },
  { category: "Compras", text: "Prefira produtos com menor embalagem ou embalagem reciclável.", impact_tco2_year: 0.05, difficulty: "Fácil" },
  { category: "Compras", text: "Compre menos, mas melhor — produtos de maior durabilidade reduzem o ciclo de descarte.", impact_tco2_year: 0.18, difficulty: "Médio" },
  { category: "Compras", text: "Doe ou venda itens que não usa mais em vez de descartá-los.", impact_tco2_year: 0.08, difficulty: "Fácil" },
]

tips_data.each { |t| Tip.create!(t) }
puts "#{Tip.count} dicas criadas."
