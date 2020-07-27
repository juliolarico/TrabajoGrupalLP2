<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Matricula</title>
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idmatricula;
            String s_idestudiante;
            String s_idcurso;
            String s_idcarrera;
            String s_ciclo;
        %>
    </head>
    <body>       
        <%
            try {
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idestudiante = request.getParameter("f_idestudiante");
                if (s_accion != null && s_accion.equals("M1")) {
                    consulta = " select idestudiante, idcurso, idcarrera, ciclo "
                            + " from matricula "
                            + " where "
                            + " idmatricula = " + s_idmatricula;
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>    
        <form name="EditarMatriculaForm" action="matricula.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">DatosMatricula</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ID Estudiante: </td>
                        <td><input type="text" name="f_idestudiante" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>ID Curso: </td>
                        <td><input type="text" name="f_idcurso" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>ID Carrera: </td>
                        <td><input type="text" name="f_idcarrera" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8" /></td>
                    </tr>
                    <tr>
                        <td>Ciclo: </td>
                        <td><input type="text" name="f_ciclo" value="<% out.print(rs.getString(4)); %>" maxlength="12" size="15" /></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idmatricula" value="<%out.print(s_idmatricula);%>" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>                                    
        <%
            }
        } else {
        %>
        <form name="AgregarMatriculaForm" action="matricula.jsp" method="GET">
            <table border="0" align="center" class="ecologico" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Matricula</th>                    
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ID Estudiante: </td>
                        <td><input type="text" name="f_idestudiante" value="" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>ID Curso: </td>
                        <td><input type="text" name="f_idcurso" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>ID Carrera: </td>
                        <td><input type="text" name="f_idcarrera" value=""maxlength="8" size="8" /></td>
                    </tr>
                    <tr>
                        <td>Ciclo: </td>
                        <td><input type="text" name="f_ciclo" value="" maxlength="12" size="15" /></td>
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
                        Datos Matricula
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>ID Estudiante</th>
                    <th>ID Curso</th>
                    <th>ID Carrera</th>
                    <th>Ciclo</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>       
            <%
                if (s_accion != null) {
                    if (s_accion.equals("E")) {
                        consulta = " delete from matricula "
                                + " where  "
                                + " idestudiante = " + s_idmatricula + "; ";
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    } else if (s_accion.equals("C")) {
                        s_idestudiante = request.getParameter("f_idestudiante");
                        s_idcurso = request.getParameter("f_idcurso");
                        s_idcarrera = request.getParameter("f_idcarrera");
                        s_ciclo = request.getParameter("f_ciclo");
                        consulta = " insert into "
                                + " matricula (idestudiante, idcurso, idcarrera, ciclo)"
                                + " values('" + s_idestudiante + "','" + s_idcurso + "','" + s_idcarrera + "','" + s_ciclo + "');  ";
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    } else if (s_accion.equals("M2")) {
                        s_idestudiante = request.getParameter("f_idestudiante");
                        s_idcurso = request.getParameter("f_idcurso");
                        s_idcarrera = request.getParameter("f_idcarrera");
                        s_ciclo = request.getParameter("f_ciclo");
                        consulta = "   update matricula  "
                                + " set  "
                                + " idestudiante = '" + s_idestudiante + "', "
                                + " idcurso = '" + s_idcurso + "', "
                                + " idcarrera = '" + s_idcarrera + "', "
                                + " ciclo = '" + s_ciclo + "', "
                                + " where  "
                                + " idmatricula = " + s_idmatricula + "; ";
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                }
                consulta = " Select idmatricula, idestudiante, idcurso, idcarrera, ciclo "
                        + " from matricula ";
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
                <td><a href="matricula.jsp?f_accion=E&f_idmatricula=<%out.print(ide);%>"><img src="eliminar.jpg" width="30" height="30" alt="eliminar"/></a></td>
                <td><a href="matricula.jsp?f_accion=M1&f_idmatricula=<%out.print(ide);%>"><img src="editar.png" width="30" height="30" alt="editar"/></a></td>                        
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
    </body>
    <a href="menu.jsp">Regresar al menú</a>
</html>