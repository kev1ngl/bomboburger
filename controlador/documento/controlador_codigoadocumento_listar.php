<?php
	require '../../modelo/modelo_adocumento.php';
	$MC = new Modelo_documento();
	$consulta = $MC->listar_codigodocumento();
	echo json_encode($consulta);
?>