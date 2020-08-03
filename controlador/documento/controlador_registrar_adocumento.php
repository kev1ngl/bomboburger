<?php
	$cont=0;
	if ($_FILES["id_archivo"]['tmp_name']!="") {
    $imagen=uniqid()."-".$_FILES['id_archivo']['name'];
	$ruta1=$_FILES['id_archivo']['tmp_name'];
	$destinoImagen='Archivo/'.$imagen;
	copy($ruta1, $destinoImagen); 
	$cont=1;
	}else{  
	$destinoImagen="";
	}
	$iddocumento= $_POST["iddocumento"];
	$idtipodocu = $_POST["idtipodocu"];
	$idusuario  = $_POST["idusuario"];
	/*echo "<script>'alert($iddocumento)'</script>";
	echo "<script>'alert($asunto)'</script>";
	echo "<script>'alert($idtipodocu)'</script>";
	echo "<script>'alert($idarea)'</script>";
	echo "<script>'alert($idremitente)'</script>";
	echo "<script>'alert($idusuario)'</script>";
	echo "<script>'alert($opcion)'</script>";
	echo "<script>'alert($destinoImagen)'</script>";
	echo "<script>'alert($cont)'</script>";
	echo "<script>'alert($destinoImagen)'</script>";
	echo "<script>'alert($cont)'</script>";*/
	require '../../modelo/modelo_adocumento.php';
	$MC = new Modelo_documento();
	$consulta = $MC->Registrar_adocumento($iddocumento,$idtipodocu,$idusuario,$destinoImagen,$cont);
	echo $consulta;
?>