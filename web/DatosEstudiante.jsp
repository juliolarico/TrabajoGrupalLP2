<%-- 
    Document   : DatosEstudiante
    Created on : 27/07/2020, 01:07:59 AM
    Author     : Santiago
--%>
 <%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Estudiante</title>
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <%!
            // Variables globales (Página)
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idestudiante;
            String s_nombres;
            String s_apellidos;
            String s_codigo;
            String s_dni;
            
        %>
    </head>
    <body>       
        <%
            try {
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idestudiante = request.getParameter("f_idestudiante");
                // Primera parte del modificar
                if (s_accion != null && s_accion.equals("M1")) {
                    consulta = " select nombres, apellidos, codigo, dni "
                            + " from estudiante "
                            + " where "
                            + " idestudiante = " + s_idestudiante;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>    
        <form name="EditarEstudianteForm" action="DatosEstudiante.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Editar Estudiante</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombres" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos:</td>
                        <td><input type="text" name="f_apellidos" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Codigo: </td>
                        <td><input type="text" name="f_codigo" value="<% out.print(rs.getString(3)); %>" maxlength="12" size="15" /></td>
                    </tr>
                    <tr>
                        <td>DNI: </td>
                        <td><input type="text" name="f_dni" value="<% out.print(rs.getString(4)); %>" maxlength="8" size="8" /></td>
                    </tr>
                    
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idestudiante" value="<%out.print(s_idestudiante);%>" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>                                    
        <%
            }
        } else {
            
        %>
        <form name="AgregarEstudianteForm" action="DatosEstudiante.jsp" method="GET">
            <table border="0" align="center" class="ecologico" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Estudiante</th>                    
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombres" value="" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos:</td>
                        <td><input type="text" name="f_apellidos" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Codigo: </td>
                        <td><input type="text" name="f_codigo" value=""maxlength="12" size="15" /></td>
                    </tr>
                    <tr>
                        <td>DNI: </td>
                        <td><input type="text" name="f_dni" value="" maxlength="8" size="8" /></td>
                    </tr>
  
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />                                                 
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            }
        %>        
        <table border="1" cellpadding ="2" align = "center" class="ecologico" style="margin: auto; display: table" >
            <thead>
                <tr>
                    <th colspan="8">
                        Datos Estudiante
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Codigo</th>
                    <th>DNI</th>
                    
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>       
            <%
                if (s_accion != null) {
                    
                    if (s_accion.equals("E")) {
                        consulta = " delete from estudiante "
                                + " where  "
                                + " idestudiante = " + s_idestudiante + "; ";
                        
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                        
                    } else if (s_accion.equals("C")) {
                        s_nombres = request.getParameter("f_nombres");
                        s_apellidos = request.getParameter("f_apellidos");
                        s_codigo = request.getParameter("f_codigo");
                        s_dni = request.getParameter("f_dni");
                    
                        consulta = " insert into "
                                + " estudiante (nombres, apellidos, codigo, dni) "
                                + " values('" + s_nombres + "','" + s_apellidos + "','" + s_codigo + "','" + s_dni + "');  ";
                        
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                       
                    }else if (s_accion.equals("M2")) {
                            s_nombres = request.getParameter("f_nombres");
                            s_apellidos = request.getParameter("f_apellidos");
                            s_dni = request.getParameter("f_dni");
                            s_codigo = request.getParameter("f_codigo");
                   
                            consulta =  " update estudiante "
                                        + " set "
                                        + " nombres = '"+ s_nombres +"', "
                                        + " apellidos = '" + s_apellidos + "', "
                                        + " codigo = '" + s_codigo + "', "
                                        + " dni = '" + s_dni + "' "                                     
                                        + " where "
                                        + " idestudiante = " + s_idestudiante + "; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                }
                }
                
                
                consulta = " Select idestudiante, nombres, apellidos, codigo, dni "
                        + " from estudiante ";
              
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                while (rs.next()) {
                    ide = rs.getString(1);
                    num++;
            %>
            <tr>
                <td><%out.print(num);%></td>
                <td><%out.print(rs.getString(2));%></td>
                <td><%out.print(rs.getString(3));%></td>
                <td><%out.print(rs.getString(4));%></td>
                <td><%out.print(rs.getString(5));%></td>
                <td><a href="DatosEstudiante.jsp?f_accion=E&f_idestudiante=<%out.print(ide);%>"><img src="eliminar.jpg" width="30" height="30" alt="Eliminar"/>
                    </a></td>
                    <td><a href="DatosEstudiante.jsp?f_accion=M1&f_idestudiante=<%out.print(ide);%>"><img src="editar.png" width="30" height="30" alt="Editar"/>
                        </a></td>                        
            </tr>                    
            <%
                    }
                    
                    rs.close();
                    pst.close();
                    cn.close();
                } catch (Exception e) {
                    out.print("Error SQL");
                }
            %>
        </table>
        <a href="menu.jsp">Regresar al menú</a>
    </body>
</html>