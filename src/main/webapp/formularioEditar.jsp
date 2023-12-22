<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    int id=Integer.parseInt(request.getParameter("id"));
%>
<h2>Introduzca los datos a editar:</h2>
<form method="get" action="editarCliente.jsp">
    nombre cliente <input type="text" name="nombre_cliente"/></br>
    nombre contacto <input type="text" name="nombre_contacto"/></br>
    apellido contacto <input type="text" name="apellido_contacto"/></br>
    telefono <input type="text" name="telefono"/></br>
    direccion <input type="text" name="linea_direccion"/></br>
    ciudad <input type="text" name="ciudad"/></br>
    region <input type="text" name="region"/></br>
    pais <input type="text" name="pais"/></br>
    codigo_postal <input type="text" name="codigo_postal"/></br>
    limite credito <input type="number" name="limite_credito"/></br>
    <input type="hidden" name="codigo" value="<%=id%>"/>




    <input type="submit" value="Aceptar">
</form>
</body>
<%
    String error =(String) session.getAttribute("error");
    if(error!=null){
%>
<span style="color:red; background:yellow"><%= error %> </span>
<%
        session.removeAttribute("error");
    }
%>
</html>