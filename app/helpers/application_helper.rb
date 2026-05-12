module ApplicationHelper
  include Chartkick::Helper

  MESES_PT = %w[Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro].freeze

  def meses_options(mes_selecionado = Date.today.month)
    MESES_PT.each_with_index.map do |nome, i|
      tag.option(nome, value: i + 1, selected: (i + 1) == mes_selecionado)
    end.join.html_safe
  end

  def formatar_data(datetime)
    "#{datetime.day} de #{MESES_PT[datetime.month - 1]} de #{datetime.year}"
  end
end
