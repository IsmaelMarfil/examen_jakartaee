<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%

    List<String> errores = (List<String>) session.getAttribute("erroresValidacion");
    session.removeAttribute("erroresValidacion"); // Limpiar la sesión después de usar los errores

    if (errores != null && !errores.isEmpty()) {
        for (String error : errores) {
%>
<div class="error-message"><%= error %></div>
<%
        }
    }

    //CÓDIGO DE VALIDACIÓN
    int id = -1;
    id=Integer.parseInt(request.getParameter("codigo"));

    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int codigo_cliente = -1;
    String nombre_cliente=null;
    String nombre_contacto=null;
    String apellido_contacto = null;
    String telefono = null;
    String linea_direccion = null;
    String ciudad = null;
    String region = null;
    String pais = null;
    int codigo_postal = -1;
    int limite_credito = -1;
    boolean flagcodCli = false;
    boolean flagnomcli = false;
    boolean flagnomcont = false;
    boolean flagapecont= false;
    boolean flagtel= false;
    boolean flaglineadireccion = false;
    boolean flagCiudad = false;
    boolean flagRegion = false;
    boolean flagPais = false;
    boolean flagcp = false;
    boolean flaglimite = false;

    SimpleDateFormat format =new SimpleDateFormat("YYYY-MM-DD");
    try {



        if (request.getParameter("nombre_cliente").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagnomcli = true;
        nombre_cliente = request.getParameter("nombre_cliente");
        if (request.getParameter("nombre_contacto").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagnomcont = true;
        nombre_contacto = request.getParameter("nombre_contacto");
        if (request.getParameter("apellido_contacto").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagapecont = true;
        apellido_contacto = request.getParameter("apellido_contacto");
        if (request.getParameter("telefono").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagtel = true;
        telefono = request.getParameter("telefono");
        if (request.getParameter("linea_direccion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flaglineadireccion = true;
        linea_direccion = request.getParameter("linea_direccion");
        if (request.getParameter("ciudad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagCiudad = true;
        ciudad = request.getParameter("ciudad");
        if (request.getParameter("region").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagRegion = true;
        region = request.getParameter("region");
        if (request.getParameter("pais").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagPais = true;
        pais = request.getParameter("pais");
        if(Integer.parseInt(request.getParameter("codigo_postal"))<0)throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagcp=true;
        codigo_postal=Integer.parseInt(request.getParameter("codigo_postal"));
        if(Integer.parseInt(request.getParameter("limite_credito"))<0)throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flaglimite=true;
        limite_credito=Integer.parseInt(request.getParameter("limite_credito"));




    } catch (Exception ex) {
        ex.printStackTrace();





    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tienda", "user", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql ="UPDATE partido SET nombre_cliente = ?, nombre_contacto = ?, apellido_contacto = ?, telefono = ? ,linea_direccion=?,ciudad=?, region=?, pais=?, codigo_postal=?, limite_credito=? WHERE id = ?";

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setString(idx++, nombre_cliente);
            ps.setString(idx++, nombre_contacto);
            ps.setString(idx++, apellido_contacto);
            ps.setString(idx++, telefono);
            ps.setString(idx++, linea_direccion);
            ps.setString(idx++, ciudad);
            ps.setString(idx++, region);
            ps.setString(idx++, pais);
            ps.setInt(idx++, codigo_postal);
            ps.setInt(idx++, limite_credito);
            ps.setInt(idx++, codigo_cliente);


            int filasAfectadas = ps.executeUpdate();
            System.out.println("CLIENTES EDITADOS:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        //out.println("Socio dado de alta.");

        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);
        //response.sendRedirect("pideNumeroSocio.jsp?socioIDADestacar="+numero);

        response.sendRedirect("index.jsp");

    } else {

        // Almacenar errores en la sesión
        session.setAttribute("erroresValidacion", errores);

        // Realizar forwarding a la página anterior (formularioSocio.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("formularioEditar.jsp");
        dispatcher.forward(request, response);

    }
%>

</body>
</html>