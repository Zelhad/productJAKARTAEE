<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
	<h2>Add product</h2>
	<form action="${pageContext.request.contextPath}/insert" method="post">

		<label for="href">Href *</label> <input type="text" id="href"
			name="href"><br> <br> <label for="description">Description</lebel>
			<textarea type="textarea" id="description" name="description"></textarea><br />
		<br /> <label for="is_bundle">Is Bundle : </label><input
			type="checkbox" id="is_bundle" name="is_bundle" value="true" /><br />
		<br> <label for="is_visible">Is customer Vsible :</label> <input
			type="checkbox" name="is_customer_visible" value="tree"><br />
		<br /> <label for="name">Name: </label><input type="text" name="name"><br />
			<br /> <label for="order_date">Order Date
				(YYYY-MM-DDHH:MM:SS) :</label><input type="datetime-local" id="order_date"
			name="order_date" /> <br /> <br /> <input type="submit"
			value="save product ">
	</form>
</body>
</html>