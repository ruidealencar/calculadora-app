class CalculadoraController < ApplicationController
  def index
  end

  def calcular
  	@resultado = case params[:operacao]
  	when '+'
  		params[:primeiro_numero].to_f + params[:segundo_numero].to_f
  	when '-'
  		params[:primeiro_numero].to_f - params[:segundo_numero].to_f
  	when '*'
  		params[:primeiro_numero].to_f * params[:segundo_numero].to_f
  	when '/'
  		params[:primeiro_numero].to_f / params[:segundo_numero].to_f
  	else
  		'Selecione um operador'
  	end

  	render inline: render_to_string(partial: 'resultado')
  end
end
