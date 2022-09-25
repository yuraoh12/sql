package com.sbs.example.demo.servlet;
import java.io.IOException;
import java.io.Writer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/home/hello")
@WebServlet("/s/home/hello")
public class HomeHelloServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
		String lang = request.getParameter("lang");

		Writer writer = response.getWriter();

		if ( lang.equals("한글") )
		{

		if (lang.equals("한글")) {
			writer.append("안녕하세요.");
		}
		else {
		} else {
			writer.append("hello!");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}