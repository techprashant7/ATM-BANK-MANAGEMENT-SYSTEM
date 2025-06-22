<%@ include file="dbConnection.jsp" %>
<%
    String pin = (String) session.getAttribute("pin");
    if (pin == null) {
        response.sendRedirect("login.jsp");
    }

    String action = request.getParameter("action");
    if ("withdraw".equals(action)) {
        String amountStr = request.getParameter("amount");

        if (amountStr != null && !amountStr.isEmpty()) {
            try {
                double amount = Double.parseDouble(amountStr);

                // Check balance
                String checkBalanceQuery = "SELECT SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) AS balance FROM bankk WHERE pin = ?";
                PreparedStatement pstmtCheckBalance = con.prepareStatement(checkBalanceQuery);
                pstmtCheckBalance.setString(1, pin);
                ResultSet rs = pstmtCheckBalance.executeQuery();

                double balance = 0;
                if (rs.next()) {
                    balance = rs.getDouble("balance");
                }

                if (balance < amount) {
                    out.println("<script>alert('Insufficient balance');</script>");
                } else {
                    // Insert withdrawal transaction
                    String query = "INSERT INTO bankk (pin, `date`, transaction_type, amount) VALUES (?, CURRENT_TIMESTAMP, 'withdrawal', ?)";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, pin);
                    pstmt.setDouble(2, amount);
                    pstmt.executeUpdate();

                    out.println("<script>alert('Rs. " + amount + " Debited Successfully!');</script>");
                }
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fast Cash</title>
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

        .fastcash-container {
            background: #ffffff;
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

        .button-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
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
        }

        button:hover {
            background-color: #0056b3;
        }

        .back-btn {
            background-color: #dc3545;
            margin-top: 15px;
        }

        .back-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <div class="fastcash-container">
        <h1>Select Withdrawal Amount</h1>
        <form action="fastcash.jsp" method="post">
            <input type="hidden" name="action" value="withdraw">
            <div class="button-container">
                <button type="submit" name="amount" value="100">Rs. 100</button>
                <button type="submit" name="amount" value="500">Rs. 500</button>
                <button type="submit" name="amount" value="1000">Rs. 1000</button>
                <button type="submit" name="amount" value="2000">Rs. 2000</button>
                <button type="submit" name="amount" value="5000">Rs. 5000</button>
                <button type="submit" name="amount" value="10000">Rs. 10000</button>
            </div>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
    </div>

</body>
</html>
