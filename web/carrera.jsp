<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>carrera</title>
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <%!
            // Variables 
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idcarrera;//ss_idestudiante
            String s_nombre;
        %>
    </head>
    <body>
        
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idcarrera = request.getParameter("f_idcarrera");
                // Primera parte del modificar
                if (s_accion!=null && s_accion.equals("M1")) {
                    consulta =  "   select nombre  "
                                + " from carrera  "
                                + " where  "
                                + " idcarrera =  " + s_idcarrera;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                            
                        
                    %>    
                <form name="EditarCarreraForm" action="carrera.jsp" method="GET">
                    <table border="0" align="center">
                        <thead>
                            <tr>
                                <th colspan="2">Editar Carrera</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Nombre:</td>
                                <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <input type="submit" value="Editar" name="f_editar" />
                                    <input type="hidden" name="f_accion" value="M2" />
                                    <input type="hidden" name="f_idcarrera" value="<%out.print(s_idcarrera);%>" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                 
                    
                    <%
                        }
                }else{
                // Si no se hace la primera parte del modidicar debe mostrar el 
                // formulario de agregar estudiante

        %>
        <form name="AgregarCarreraForm" action="carrera.jsp" method="GET">
            <table border="0" align="center" class="ecologico" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Carrera</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="25" /></td>
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
                        Datos Carrera
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>

        
        <%        
                
                
                if (s_accion !=null) {
                    
                    // Ejecutar la eliminación de estudiantes
                    if (s_accion.equals("E")) {
                            consulta =    " delete from carrera "
                                        + " where  "
                                        + " idcarrera = " + s_idcarrera +"; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")){
                            s_nombre = request.getParameter("f_nombre");
                            
                            consulta =    " insert into "
                                        + " carrera (nombre)"
                                        + " values('"+ s_nombre +"');  ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                            s_nombre = request.getParameter("f_nombre");
                            consulta =  "   update carrera  "
                                        + " set  "
                                        + " nombre = '"+ s_nombre +"' "
                                        
                                        + " where  "
                                        + " idcarrera = " + s_idcarrera + "; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }
                    
                }
                // Listar los estudiantes de la TABLA ESTUDIANTE
                consulta= " Select idcarrera, nombre "
                        + " from carrera ";
                //out.print(consulta);
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
                        
                        <td><a href="carrera.jsp?f_accion=E&f_idcarrera=<%out.print(ide);%>"><img src="eliminar.jpg" width="30" height="30" alt="borrar"/>
                            </a></td>
                            <td><a href="carrera.jsp?f_accion=M1&f_idcarrera=<%out.print(ide);%>"><img src="editar.png" width="30" height="30" alt="Lapiz"/>
                                </a></td>
                        
                    </tr>                    
                    <%
                    }
                    // Se cierra todas las conexiones
                    rs.close();
                    pst.close();
                    cn.close();
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        </table>
        <a href="menu.jsp">Regresar al menú</a>
    </body>
</html>