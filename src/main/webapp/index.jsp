<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 04/12/2023
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<h1>Crear pedido</h1>
<td>
  <form method="get" action="formularioEditar.jsp">
    <input type="submit" value="crear">
  </form>
</td>
<h1>Listado Pedidos</h1>
<%
  //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
  //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/tienda","user", "user");

  //UTILIZAR STATEMENT SÓLO EN QUERIES NO PARAMETRIZADAS.
  Statement s = conexion.createStatement();
  ResultSet listado = s.executeQuery ("SELECT * FROM pedido");
%>
<%
  Integer pedidoIDADestacar = (Integer)session.getAttribute("pedidoIDADestacar");
  String claseDestacar = "";
  while (listado.next()) {
    claseDestacar = (pedidoIDADestacar != null
            && pedidoIDADestacar==listado.getInt("pedidoID") ) ?
            "destacar" :  "";
%>
<tr>
  <td >
    <%=listado.getInt("codigo_pedido")%>
  </td>
  <td><%=listado.getDate("fecha_pedido")%>
  </td>
  <td><%=listado.getDate("fecha_esperada")%>
  </td>
  <td><%=listado.getDate("fecha_entrega")%>
  </td>
  <td><%=listado.getString("estado")%>
  </td>
  <td><%=listado.getString("comentarios")%>
  </td>
  <td><%=listado.getInt("codigo_cliente")%>
  </td>
  <td>
    <form method="get" action="borrarpartido.jsp">
      <input type="hidden" name="codigo" value="<%=listado.getInt("codigo_pedido") %>"/>
      <input type="submit" value="borrar">
    </form>
  </td>
  <td>
    <form method="get" action="formularioEditar.jsp">
      <input type="hidden" name="codigo" value="<%=listado.getString("codigo_pedido") %>"/>
      <input type="submit" value="modificar">
    </form>
  </td>
</tr>
<%
  } // while

  listado.close();
  s.close();
  conexion.close();
%>
</body>
</html>
