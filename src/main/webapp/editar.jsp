<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.emergentes.Registro"%>
<%
    Registro reg = (Registro) request.getAttribute("registro");
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
            .button-container {
                text-align: center; /* Centra el contenido horizontalmente */
            }

            .but {
                box-shadow: 1px 1px 2px; /* Estilos de sombra */
            }
            .inicial{
                display: flex;
                padding: 3rem;
            }
            
        .c1{
            width: 50%;
            padding: 1rem;
            margin-right: 3rem;
        }
        .c2{
            width: 60%;
            padding: 2rem;
            margin-right: 3rem;
        }
        </style>
    </head>
    <body>
        <h1>Registro en Seminarios</h1>

        <form action="MainServlet" method="post" >
        <div class="inicial">
            <div class="c1">
                <fieldset>
                    <legend>Datos </legend>
                    <table>
                        <tr style="display: none;">
                            <td>Id</td>
                            <td><input type="text" name="id" value="<%=reg.getId()%>" size="2" readonly></td>
                        </tr>
                        <tr>
                            <td>Fecha </td>
                            <td><input type="date" name="fecha" value="<%=reg.getFecha() != null ? reg.getFecha() : ""%>" placeholder="fecha"></td>
                        </tr>
                        <tr>
                            <td>Nombre </td>
                            <td><input type="text" name="nombre" value="<%=reg.getNombre() != null ? reg.getNombre() : ""%>" placeholder="nombre"></td>
                        </tr>
                        <tr>
                            <td>Apellidos </td>
                            <td><input type="text" name="apellidos" value="<%=reg.getApellidos() != null ? reg.getApellidos() : ""%>" placeholder="apellidos"></td>
                        </tr>
                        <tr>
                            <td>Turnos </td>
                            <td>
                                <input type="radio" id="mañana" name="turno" value="Manana">
                                <label for="mañana">Mañana</label>
                                <input type="radio" id="tarde" name="turno" value="Tarde">
                                <label for="tarde">Tarde</label>
                                <input type="radio" id="noche" name="turno" value="Noche">
                                <label for="noche">Noche</label>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
            <div class="i1">
                <fieldset class="c2">
                    <legend>Seminarios disponibles</legend>
                    <table>
                        <tr>
                            <td>
                                <%
                                    String[] seminariosSeleccionados = reg.getSeminario(); // Obtener los seminarios seleccionados
                                    List<String> seminariosDisponibles = Arrays.asList("Inteligencia Artificial", "Machine Learning", "Simulacion con Arena", "Robotica Educativa"); // Lista de todos los seminarios disponibles

                                    for (String seminarioDisponible : seminariosDisponibles) {
                                        boolean seleccionado = false; // Verificar si el seminario está seleccionado
                                        if (seminariosSeleccionados != null) {
                                            for (String seminarioSeleccionado : seminariosSeleccionados) {
                                                if (seminarioSeleccionado.equals(seminarioDisponible)) {
                                                    seleccionado = true;
                                                    break;
                                                }
                                            }
                                        }
                                %>
                                    <input type="checkbox" id="<%=seminarioDisponible%>" name="seminario" value="<%=seminarioDisponible%>" <%=seleccionado ? "checked" : ""%>>
                                    <label for="<%=seminarioDisponible%>"><%=seminarioDisponible%></label><br>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
        <br>    
        <div class="button-container">
            <input type="submit" value="Enviar Registro" class="but">  
        </div>   
    </body>
</html>
