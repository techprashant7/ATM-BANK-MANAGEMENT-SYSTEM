<%@ include file="dbConnection.jsp" %>
<%
    String pin = (String) session.getAttribute("pin");
    if (pin == null) {
        response.sendRedirect("login.jsp");
    }

    String action = request.getParameter("action");
    if ("deposit".equals(action)) {
        String amountStr = request.getParameter("amount");

        if (amountStr != null && !amountStr.isEmpty()) {
            try {
                double amount = Double.parseDouble(amountStr);

                // Check PIN in login table (foreign key source)
                String checkQuery = "SELECT pin FROM signupthree WHERE pin = ?";
                PreparedStatement checkStmt = con.prepareStatement(checkQuery);
                checkStmt.setString(1, pin);  // Keep as String
                ResultSet rs = checkStmt.executeQuery();
                
                if (!rs.next()) {
                    out.println("<script>alert('Invalid PIN');</script>");
                    return;
                }

                // Insert transaction
                String query = "INSERT INTO bankk (pin, date, transaction_type, amount) VALUES (?, CURRENT_TIMESTAMP, 'Deposit', ?)";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, pin);  // Store as String
                pstmt.setDouble(2, amount);
                pstmt.executeUpdate();

                out.println("<script>alert('Rs. " + amount + " Deposited Successfully!');</script>");
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deposit</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        button {
            background-color: #28a745;
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
            background-color: #218838;
        }

        .back-btn {
            background-color: #dc3545;
        }

        .back-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Deposit Funds</h1>
        <form action="deposit.jsp" method="post">
            <input type="hidden" name="action" value="deposit">
            <input type="text" name="amount" id="amount" placeholder="Enter Amount" required>
            <button type="submit">Deposit</button>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
    </div>

</body>
</html>
