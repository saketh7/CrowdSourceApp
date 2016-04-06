<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet">
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
 
<!-- optionally if you need to use a theme, then include the theme file as mentioned below -->
<link href="css/theme-krajee-svg.css" media="all" rel="stylesheet" type="text/css" />
 
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.js"></script>
<script src="js/star/star-rating.js" type="text/javascript"></script>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form name="rate" method="get" action="rate.jsp">
<input id="input-id" type="number" name="rating" class="rating" min=1 max=5 step=1 data-size="xs">
 <input type="submit"  value="test" />
<!-- <input type="button" onclick="alert(document.getElementsByName('rating').value);" value="test" /> -->
</form>
<script type="text/javascript">
$("#input-id").rating({min:1, max:5, step:1, size:'xs'});
</script>



</body>
</html>