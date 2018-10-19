$(document).ready(function() {
	$('#btn-calc').click(function() {
		var primeiro_numero = $('#primeiro_numero').val();
		var operacao = $('#operacao').val();
		var segundo_numero = $('#segundo_numero').val();
		
		$.ajax({
			url: '/calculadora/calcular',
			post: 'POST',
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