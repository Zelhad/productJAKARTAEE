// InsertProductServlet.java
package productPackage.Servlet;

import java.io.IOException;
import java.time.OffsetDateTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import productPackage.dao.PRODUCTDAO;
import productPackage.model.Product;

public class InsertProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PRODUCTDAO productDao;

	@Override
	public void init() {
		productDao = new PRODUCTDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Create Product object from request parameters
			Product product = createProductFromRequest(request);

			// Insert product
			productDao.insertProduct(product);

			// Forward to success page
			request.setAttribute("message", "Product inserted successfully!");
			RequestDispatcher dispatcher = request.getRequestDispatcher("product-list.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			// Log the error
			log("Error inserting product: " + e.getMessage(), e);

			// Forward to error page
			request.setAttribute("error", "An error occurred while inserting the product");
			RequestDispatcher dispatcher = request.getRequestDispatcher("product-form.jsp");
			dispatcher.forward(request, response);
		}

	}

	private Product createProductFromRequest(HttpServletRequest request) {
		Product product = new Product();

		// Required fields

		// Optional fields
		product.setHref(request.getParameter("href"));
		product.setDescription(request.getParameter("description"));
		product.setName(request.getParameter("name"));
		product.setBundle("true".equals(request.getParameter("is_bundle")));
		product.setCustomerVisible("true".equals(request.getParameter("is_customer_visible")));
		String orderDateStr = request.getParameter("order_date");
		OffsetDateTime orderDate = null;

		if (orderDateStr != null && !orderDateStr.isBlank()) {
			// Append a default offset (e.g. system default)
			orderDateStr += "+00:00"; // or use your local offset
			orderDate = OffsetDateTime.parse(orderDateStr);
		}

		product.setOrderDate(orderDate);

		return product;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("product-form.jsp");
		dispatcher.forward(req, resp);
	}
}