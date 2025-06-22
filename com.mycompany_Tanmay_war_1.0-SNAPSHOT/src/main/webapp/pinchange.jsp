<%@ include file="dbConnection.jsp" %>
<%
    String pin = (String) session.getAttribute("pin");
    if (pin == null) {
        response.sendRedirect("login.jsp");
    }

    String newPin = request.getParameter("newPin");
    String confirmPin = request.getParameter("confirmPin");

    if (newPin != null && confirmPin != null) {
        if (newPin.equals(confirmPin)) {
            try {
                String query = "UPDATE login SET pin = ? WHERE pin = ?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, newPin);
                pstmt.setString(2, pin);
                pstmt.executeUpdate();

                session.setAttribute("pin", newPin);
                out.println("<script>alert('PIN changed successfully!'); window.location='main_class.jsp';</script>");
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
            }
        } else {
            out.println("<script>alert('PINs do not match!');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change PIN</title>
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

        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-change {
            background-color: #28a745;
            color: white;
        }

        .btn-change:hover {
            background-color: #218838;
        }

        .btn-back {
            background-color: #dc3545;
            color: white;
            margin-top: 10px;
        }

        .btn-back:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Change Your PIN</h1>
        <form action="pinchange.jsp" method="post">
            <div class="form-group">
                <label for="newPin">New PIN:</label>
                <input type="password" name="newPin" id="newPin" required>
            </div>
            <div class="form-group">
                <label for="confirmPin">Confirm PIN:</label>
                <input type="password" name="confirmPin" id="confirmPin" required>
            </div>
            <button type="submit" class="btn btn-change">Change PIN</button>
        </form>
        <button onclick="window.location.href='main_class.jsp'" class="btn btn-back">Back</button>
    </div>

</body>
</html>

