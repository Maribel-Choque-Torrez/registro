
<%@page import="com.emergentes.Registro"%>
<%@page import="java.util.ArrayList"%>
<%
    
    //si devuelve null es la primera vez
    if (session.getAttribute("registroseminario") == null){
    ArrayList<Registro> lisAux= new ArrayList<Registro> ();
    session.setAttribute("registroseminario", lisAux);
    }
    ArrayList<Registro> lista = (ArrayList<Registro>)session.getAttribute("registroseminario");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            h1 {
            text-align: center; /* Centra horizontalmente el texto */
            }
            
            /* Estilo para las filas de datos adicionales */
            tr.data-row {
                background-color: #ddd; /* Gris claro */
            }

            /* Estilo para las filas pares */
            tr:nth-child(even) {
                background-color: #ddd; /* Gris claro */
            }

            /* Estilo para las filas impares */
            tr:nth-child(odd) {
                background-color: white; /* Blanco */
            }
</style>
    </head>
    <body>
        <h1 >Listado de Inscritos</h1>
        <a href="MainServlet?action=nuevo"><input style="box-shadow: 1px 1px 2px; " type="submit" value="Nuevo"></a>
        <br><br>
        <table border="1" style="width: 95% ; margin:0 auto; text-aling: center;" cellspacing="0"<>
            <tr style="background:#717D7E ">
                
                <th>Id</th>
                <th>Fecha</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Turno</th>
                <th>Seminarios</th>
                <th></th>
                <th></th>
            </tr>
            
            <%
                if (lista!=null){
                    int rowCount = 0;
            for(Registro item: lista){
            %>
            <tr class="<%= rowCount % 2 == 0 ? "data-row1" : "data-row2" %>">
                <td><%=item.getId() %></td>
                <td><%=item.getFecha()%></td>
                <td><%=item.getNombre()%></td>
                <td><%=item.getApellidos()%></td>
                <td><%=item.getTurno()%></td>
                 <td>
                <% 
                // Obtener el array de seminarios del registro
                String[] seminarios = item.getSeminario();
                StringBuilder seminariosStr = new StringBuilder(); // StringBuilder para construir la cadena de seminarios

                // Verificar si el array de seminarios no es nulo
                if (seminarios != null) {
                    // Iterar sobre los elementos del array
                    for (String seminario : seminarios) {
                        // Agregar cada seminario al StringBuilder
                        seminariosStr.append(seminario).append(", ");
                    }
                }

                // Convertir el StringBuilder a String y eliminar la última coma
                String seminariosString = seminariosStr.toString();
                if (seminariosString.endsWith(", ")) {
                    seminariosString = seminariosString.substring(0, seminariosString.length() - 2);
                }

                // Imprimir la cadena de seminarios
                out.println(seminariosString);
                %>
            </td>
                <td><a href="MainServlet?action=editar&id=<%=item.getId() %>">Editar</a></td>
                <td><a href="MainServlet?action=eliminar&id=<%=item.getId() %>"onclick="return(confirm('Esta suguro de eliminar?'))"  
                       >Eliminar</a></td>
                
                
            </tr>
            <%
                rowCount++;
                }
            }
            %>
            
        </table>
    </body>
</html>
