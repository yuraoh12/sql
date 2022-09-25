package ArticleListServlet;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.demo.db.DBConnection;

@WebServlet("/article/list")
@WebServlet("/s/article/list")
public class ArticleListServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public ArticleListServlet() {
		super();
@@ -22,17 +22,12 @@ protected void doGet(HttpServletRequest request, HttpServletResponse response)
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");

		DBConnection.DB_NAME = "site3";
		DBConnection.DB_USER = "sbsst";
		DBConnection.DB_PASSWORD = "sbs123414";
		DBConnection.DB_PORT = 3306;

		DBConnection dBConnection = new DBConnection();
		DBConnection dBConnection = new DBConnection("localhost", "site3", "sbsst", "sbs123414", 3306);
		dBConnection.connect();
		

		Map<String, Object> articleRow = dBConnection.selectRow("SELECT * FROM article LIMIT 1");
		
		response.getWriter().append((String)articleRow.get("body"));

		response.getWriter().append((String) articleRow.get("body"));
		dBConnection.close();
	}
}