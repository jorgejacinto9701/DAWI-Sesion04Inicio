<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>
<title>Ejemplos de CIBERTEC - Jorge Jacinto </title>
</head>
<body>

<div class="container">
<h3>Registra Docente</h3>
	
	<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
			<div class="row">
				<div class="form-group col-md-9">
					<label class="control-label" for="id_nombre">Nombre</label>
					<input class="form-control" type="text" id="id_nombre" name="nombre" placeholder="Ingrese el nombre">
				</div>
				<div class="form-group col-md-3">
					<label class="control-label" for="id_dni">DNI</label>
					<input class="form-control" id="id_dni" name="dni" placeholder="Ingrese el DNI" type="text" maxlength="8"/>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-4">
					<label class="control-label" for="id_departamento">Departamento</label>
					<select id="id_departamento" name="ubigeo.departamento" class='form-control'>
						<option value=" ">[ Seleccione ]</option>    
					</select>
			    </div>
				<div class="form-group col-md-4">
					<label class="control-label" for="id_provincia">Provincia</label>
					<select id="id_provincia" name="ubigeo.departamento" class='form-control'>
						<option value=" ">[ Seleccione ]</option>    
					</select>
			    </div>
				<div class="form-group col-md-4">
					<label class="control-label" for="id_distrito">Distrito</label>
					<select id="id_distrito" name="ubigeo.idUbigeo" class='form-control'>
						<option value=" ">[ Seleccione ]</option>    
					</select>
			    </div>				
		    </div>
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registra</button>
				</div>
			</div>
	</div>
	</form>
	
</div>

<script type="text/javascript">

$.getJSON("listaDepartamentos", {}, function(data){ 
	$.each(data, function(i, item){
		$("#id_departamento").append("<option value='"+ item +"'>"+ item +"</option>"); 
	});
});

$("#id_departamento").change(function(){
	var val_dep = $("#id_departamento").val();

	$("#id_provincia").empty();
	$("#id_provincia").append("<option value=' '>[ Seleccione ]</option>");

	$("#id_distrito").empty();
	$("#id_distrito").append("<option value=' '>[ Seleccione ]</option>");

	$.getJSON("listaProvincias", {"departamento":val_dep}, function(data){ 
		$.each(data, function(i, item){
			$("#id_provincia").append("<option value='"+ item +"'>"+ item +"</option>"); 
		});
	});
	
 });
 
$("#id_provincia").change(function(){
	var val_dep = $("#id_departamento").val();
	var val_pro = $("#id_provincia").val();

	$("#id_distrito").empty();
	$("#id_distrito").append("<option value=' '>[ Seleccione ]</option>");
	
	$.getJSON("listaDistritos", {"departamento":val_dep,"provincia":val_pro}, function(data){ 
		$.each(data, function(i, item){
			$("#id_distrito").append("<option value='"+ item.idUbigeo +"'>"+ item.distrito +"</option>"); 
		});
	});
	
 });



$("#id_registrar").click(function (){ 

	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()){
		$.ajax({
			type: 'POST',  
			data: $("#id_form").serialize(),
			url: 'registraDocente',
			success: function(data){
				mostrarMensaje(data.MENSAJE);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});

function limpiar(){
	$("#id_nombre").val('');
	$("#id_dni").val('');
	$("#id_provincia").empty();
	$("#id_distrito").empty();
	$("#id_provincia").append("<option value=' '>[ Seleccione ]</option>");
	$("#id_distrito").append("<option value=' '>[ Seleccione ]</option>");
	$("#id_departamento").val(' ');
	$("#id_provincia").val(' ');
	$("#id_distrito").val(' ');
}

$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	nombre: {
    		selector : '#id_nombre',
            validators: {
                notEmpty: {
                    message: 'El nombre es un campo obligatorio'
                },
                stringLength :{
                	message:'El nombre es de 2 a 100 caracteres',
                	min : 2,
                	max : 100
                }
            }
        },
        dni:{
            selector: "#id_dni",
            validators:{
                notEmpty: {
                     message: 'El dni es obligatorio'
                },
                regexp: {
                    regexp: /^[0-9]{8}$/,
                    message: 'el dni es 8 dígitos'
                }
            }
        },
        departamento: {
    		selector : '#id_departamento',
            validators: {
            	notEmpty: {
                    message: 'El departamento un campo obligatorio'
                },
            }
        },
        provincia: {
    		selector : '#id_provincia',
            validators: {
            	notEmpty: {
                    message: 'La provincia un campo obligatorio'
                },
            }
        },
        distrito: {
    		selector : '#id_distrito',
            validators: {
            	notEmpty: {
                    message: 'El distrito un campo obligatorio'
                },
            }
        },
    	
    }   
});
</script>


</body>
</html>




