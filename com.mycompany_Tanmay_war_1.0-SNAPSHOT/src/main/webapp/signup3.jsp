<%@ page import="java.sql.*, java.util.Random" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page 3: Account Details</title>
    <style>
        body {
            background-color: #D7FCFC;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 60%;
            margin: auto;
            padding: 20px;
            background: #E3FFFF;
            border-radius: 10px;
            border: 1px solid black;
        }
        h2 {
            text-align: center;
        }
        label {
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .checkbox-group label {
            display: inline-block;
            width: 200px;
        }
        .btn {
            background: black;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            margin-right: 10px;
            width: 100px;
        }
        .btn:hover {
            background: gray;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Page 3: Account Details</h2>
        <form action="signup3.jsp" method="post">
            <div class="form-group">
                <label>Account Type:</label><br>
                <input type="radio" name="atype" value="Saving Account"> Saving Account
                <input type="radio" name="atype" value="Fixed Deposit Account"> Fixed Deposit Account
                <input type="radio" name="atype" value="Current Account"> Current Account
                <input type="radio" name="atype" value="Recurring Deposit Account"> Recurring Deposit Account
            </div>

            <div class="form-group">
                <label>Card Number:</label>
                <strong>XXXX-XXXX-XXXX-<span id="cardLast4">****</span></strong><br>
                <small>(Your 16-digit Card Number - It will appear on ATM card, Cheque Book, and Statements)</small>
            </div>

            <div class="form-group">
                <label>PIN:</label>
                <strong>XXXX</strong><br>
                <small>(4-digit Password)</small>
            </div>

            <div class="form-group checkbox-group">
                <label>Services Required:</label><br>
                <input type="checkbox" name="services" value="ATM CARD"> ATM CARD
                <input type="checkbox" name="services" value="Internet Banking"> Internet Banking
                <input type="checkbox" name="services" value="Mobile Banking"> Mobile Banking
                <input type="checkbox" name="services" value="EMAIL Alerts"> EMAIL Alerts
                <input type="checkbox" name="services" value="Cheque Book"> Cheque Book
                <input type="checkbox" name="services" value="E-Statement"> E-Statement
            </div>

            <div class="form-group">
                <input type="checkbox" required> I hereby declare that the above entered details are correct to the best of my knowledge.
            </div>

            <div class="form-group">
                <input type="submit" name="submit" value="Submit" class="btn">
                <input type="button" value="Next" class="btn" onclick="window.location.href='deposit.jsp'">
                <input type="submit" name="cancel" value="Cancel" class="btn">
            </div>
        </form>
    </div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String formno = request.getParameter("formno");
        String atype = request.getParameter("atype");
        String[] services = request.getParameterValues("services");

        if (atype == null || services == null) {
            out.println("<script>alert('Please select an account type and at least one service.');</script>");
        } else {
            Random ran = new Random();
            long first12 = (Math.abs(ran.nextLong()) % 900000000000L) + 100000000000L;
            String card_number = String.format("%016d", first12);
            String formatted_card_number = card_number.replaceAll("(.{4})", "$1-").substring(0, 19);

            long pin_number = (Math.abs(ran.nextLong()) % 9000L) + 1000L;
            String pin = String.valueOf(pin_number);

            StringBuilder fac = new StringBuilder();
            for (String service : services) {
                fac.append(service).append(", ");
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksystem", "root", "pr@sh@nt777777");
                Statement stmt = con.createStatement();

                String q1 = "INSERT INTO signupthree VALUES('" + formno + "', '" + atype + "', '" + card_number + "', '" + pin + "', '" + fac.toString() + "')";
                String q2 = "INSERT INTO login VALUES('" + formno + "', '" + card_number + "', '" + pin + "')";

                stmt.executeUpdate(q1);
                stmt.executeUpdate(q2);

                out.println("<script>");
                out.println("alert('Generated Card Number: " + formatted_card_number + "\nGenerated PIN: " + pin + "');");
                response.sendRedirect("deposite.jsp");
                out.println("</script>");
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("<script>alert('Database Error: " + ex.getMessage() + "');</script>");
            }
        }
    }
%>
