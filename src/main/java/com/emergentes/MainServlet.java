
package com.emergentes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MainServlet", urlPatterns = {"/MainServlet"})
public class MainServlet extends HttpServlet {   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "view";
        switch (action) {
            case "view":
                response.sendRedirect("index.jsp");
                break;
            case "nuevo":
                Registro regis = new Registro();
                request.setAttribute("registro", regis);
                request.getRequestDispatcher("editar.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));

                HttpSession sesion = request.getSession();
                List<Registro> lista = (ArrayList<Registro>) sesion.getAttribute("registroseminario");
                Registro editReg = new Registro();
                for (Registro item : lista) {
                    if (item.getId() == idEditar) {
                        editReg= item;
                        break;
                    }
                }
                request.setAttribute("registro", editReg);
                request.getRequestDispatcher("editar.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                HttpSession sesion1 = request.getSession();
                List<Registro> lista1 = (ArrayList<Registro>) sesion1.getAttribute("registroseminario");
                for(Registro item : lista1){
                    System.out.println(item.toString());
                    if(item.getId() == idEliminar){
                        lista1.remove(item);
                        break;  
                    }
                }
                response.sendRedirect("index.jsp");
                break;
        }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fecha = request.getParameter("fecha");
        String nombre = request.getParameter("nombre");
        String apellidos= request.getParameter("apellidos");
        String turno= request.getParameter("turno");
        String[] seminario= request.getParameterValues("seminario");
        
        //Nuevo registro
        HttpSession ses = request.getSession();
        List<Registro> lista = (ArrayList<Registro>) ses.getAttribute("registroseminario");

        if (id == 0) {
            //nuevo registro
            Registro r = new Registro();
            int idnuevo = obtenerNuevoId(lista);
            r.setId(idnuevo);
            r.setFecha(fecha);
            r.setNombre(nombre);
            r.setApellidos(apellidos);
            r.setTurno(turno);
            r.setSeminario(seminario);
            
            lista.add(r);
        }
        else {
        for (Registro item : lista) {
            if (item.getId() == id) {
                item.setNombre(nombre);
                item.setSeminario(seminario); // Asignar los seminarios seleccionados al registro editado
                break;
            }
        }
    }

        response.sendRedirect("index.jsp");
    }

    private int obtenerNuevoId(List<Registro> lista) {
        int nuevoId = 1;
        for (Registro item : lista) {
            if (item.getId() >= nuevoId) {
                nuevoId = item.getId() + 1;
            }
        }
        return nuevoId;
    }
}
