<%@ include file="dbConnection.jsp" %>
<%
    String pin = (String) session.getAttribute("pin");
    if (pin == null) {
        response.sendRedirect("login.jsp");
    }

    String amountStr = request.getParameter("amount");

    if (amountStr != null && !amountStr.isEmpty()) {
        try {
            double amount = Double.parseDouble(amountStr);

            // Check balance
            String balanceQuery = "SELECT SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) AS balance FROM bankk WHERE pin = ?";
            PreparedStatement balanceStmt = con.prepareStatement(balanceQuery);
            balanceStmt.setString(1, pin);
            ResultSet rs = balanceStmt.executeQuery();

            double balance = 0;
            if (rs.next()) {
                balance = rs.getDouble("balance");
            }

            if (balance < amount) {
                response.sendRedirect("withdraw.jsp?error=Insufficient balance.");
            } else {
                // Insert withdrawal transaction
                String withdrawQuery = "INSERT INTO bankk(pin, `date`, transaction_type, amount) VALUES (?, ?, 'Withdrawal', ?)";
                PreparedStatement withdrawStmt = con.prepareStatement(withdrawQuery);
                withdrawStmt.setString(1, pin);
                withdrawStmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
                withdrawStmt.setDouble(3, amount);
                withdrawStmt.executeUpdate();

                response.sendRedirect("withdraw.jsp?message=Rs. " + amount + " withdrawn successfully.");
            }
        } catch (Exception e) {
            response.sendRedirect("withdraw.jsp?error=Error: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw</title>
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

        .withdraw-container {
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

        .back-btn {
            background-color: #dc3545;
        }

        .back-btn:hover {
            background-color: #c82333;
        }

        .message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="withdraw-container">
        <h1>Withdraw Funds</h1>
        <form action="withdraw.jsp" method="post">
            <label for="amount">Enter Withdrawal Amount (Max: Rs. 10,000):</label>
            <input type="text" name="amount" id="amount" placeholder="Enter Amount" required>

            <button type="submit">Withdraw</button>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>

        <%
            String errorMessage = request.getParameter("error");
            String successMessage = request.getParameter("message");

            if (errorMessage != null) {
                out.println("<p class='error'>" + errorMessage + "</p>");
            } else if (successMessage != null) {
                out.println("<p class='message'>" + successMessage + "</p>");
            }
        %>
    </div>

</body>
</html>
