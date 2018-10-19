CRIANDO UMA REQUISIÇÃO AJAX COM JQUERY

As requisições ajax (Asynchronous Javascript and XML) são bastante úteis quando você deseja realizar uma operação em sua página, onde não haja a necessidade de carregá-la por inteira.

Algumas vantagens de se utilizar esse tipo de requisição é, tempo de resposta bem mais rápido, parece mágica :b, diminui o consumo de requisições no servidor, e proporciona uma maior eficiência.

Para fixarmos melhor, vamos verificar este projeto, no qual foi desenvolvido uma calculadora utilizando requisição ajax.

--- TECNOLOGIAS UTILIZADAS:

Ruby 2.3.1

Rails 5.0.1

Sqlite3

--- PASSO A PASSO

Para iniciarmos o passo a passo, vamos criar o nosso projeto executando um rails new requisicao_ajax.
Como não iremos necessitar de todos os arquivos que um scaffold gera, vamos apenas criar o controller calculadora e uma action index, para criarmos basta executar o seguinte comando rails g controller calculadora index.
Agora vamos abir a nossa view index e colocar o código abaixo:

<h1>Calculadora</h1>
<%= number_field_tag :primeiro_numero, nil, placeholder: 'Digite um número' %>
<%= select_tag :operacao, options_for_select(['+', '-', '*', '/']), { prompt: 'Selecione' } %>
<%= number_field_tag :segundo_numero, nil, placeholder: 'Digite um número' %>
<%= submit_tag 'Calcular', id: 'btn-calc' %>
<br>
<div id="resultado" />

Observe que no submit_tag criamos um identificador id: 'btn-calc', este id é o que vamos utilizar para startar a nossa requisição ajax.

A div <div id="resultado" /> é onde iremos mostrar o retorno da nossa requisição.

Para criarmos nossa função que irá realizar a requisição, vamos primeiramente alterar a extensão do arquivo /app/assets/javascript/calculadora.coffee para /app/assets/javascript/calculadora.js. Logo após, adicione o código abaixo no arquivo:

$(document).ready(function() {
  $('#btn-calc').click(function() {
    var primeiro_numero = $('#primeiro_numero').val();
    var operacao = $('#operacao').val();
    var segundo_numero = $('#segundo_numero').val();
    
    $.ajax({
      url: '/calculadora/calcular',
      post: 'GET',
      data: {
              primeiro_numero: primeiro_numero,
              operacao: operacao,
              segundo_numero: segundo_numero
          	}
    }).done(function(retorno) {
      $('#resultado').html(retorno);
    });
  });
});

Vamos as observações.

Lembra que em nossa view index adicionamos em nosso submit_tag o identificador id: 'btn-calc', pois veja que este id que criamos, aparece no código acima informando que após ser clicado, ele vai executar a função. Veja também, que colocamos todos os valores informados nos campos de nossa tela em variáveis.

Explicando o bloco $.ajax({...});

url: URL a qual a requisição será enviada.

method: O método HTTP a ser usado para a requisição (por exemplo, "POST", "GET", "PUT").

data: São os dados (parâmetros) a serem enviados para a URL.

.done: É o retorno da requisição.

Verifique que o retorno do .done, colocamos dentro do id $('#resultado'), onde este id corresponde a div <div id="resultado" /> localizada em nossa view index.

Como podemos observar, nossa requisição vai para a seguinte URL, url: 'calculadora/calcular', controller calculadora e action calcular, mas se você reparar, nós não criamos ainda a action calcular. Então vamos lá, mãos na massa...

No controller calculadora, vamos criar a action calcular, após criarmos a action, não podemos esquecer de criarmos a rota, e para criarmos a rota, basta ir em /config/routes.rb e adicionar a seguinte linha get 'calculadora/calcular'. Agora, adicione o código abaixo na action calcular:

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

O código acima, é apenas uma condição, onde para cada caso, ele irá realizar uma operação diferente, ressalto que o calculo é de acordo com a operação que o usuário informar.