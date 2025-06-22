<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String cardNumber = request.getParameter("cardNumber");
    String pin = request.getParameter("pin");

    if (cardNumber != null && pin != null) {
        try {
            String call = "{CALL sp_AuthenticateUser(?, ?, ?)}";
            CallableStatement cstmt = con.prepareCall(call);
            cstmt.setString(1, cardNumber);
            cstmt.setString(2, pin);
            cstmt.registerOutParameter(3, Types.BOOLEAN);
            cstmt.execute();

            boolean isValid = cstmt.getBoolean(3);

            if (isValid) {
                session.setAttribute("pin", pin);
                response.sendRedirect("main_class.jsp");
            } else {
                out.println("<script>alert('Invalid Card Number or PIN');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 350px;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            text-align: left;
            margin-bottom: 5px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            transition: 0.3s;
        }

        input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            width: 100%;
            margin-top: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .forgot-link {
            display: block;
            margin-top: 10px;
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
            transition: 0.3s;
        }

        .forgot-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .signup-button {
            background-color: #28a745;
        }

        .signup-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h1>Login</h1>
        <form action="login.jsp" method="post">
            <label for="cardNumber">Card Number:</label>
            <input type="text" name="cardNumber" placeholder="Enter Card Number" required>

            <label for="pin">PIN:</label>
            <input type="password" name="pin" placeholder="Enter PIN" required>

            <button type="submit">Login</button>
        </form>

        <form action="signup.jsp" method="get">
            <button type="submit" class="signup-button">Signup</button>
             <a href="#" class="forgot-link">Forgot PIN?</a>
             <a href="index.html">Home</a>
        </form>
    </div>

</body>
</html>
