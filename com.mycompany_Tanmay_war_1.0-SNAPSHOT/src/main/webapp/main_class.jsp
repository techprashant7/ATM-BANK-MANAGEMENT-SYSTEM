<%@ include file="dbConnection.jsp" %>
<%
    String pin = (String) session.getAttribute("pin");
    if (pin == null) {
        response.sendRedirect("login.jsp");
    }

    String transaction = request.getParameter("transaction");

    if (transaction != null) {
        switch (transaction) {
            case "deposit":
                response.sendRedirect("deposit.jsp");
                break;
            case "withdrawal":
                response.sendRedirect("withdraw.jsp");
                break;
            case "fastcash":
                response.sendRedirect("fastcash.jsp");
                break;
            case "ministatement":
                response.sendRedirect("ministatement.jsp");
                break;
            case "pinchange":
                response.sendRedirect("pinchange.jsp");
                break;
            case "balance":
                response.sendRedirect("balanceenquiry.jsp");
                break;
            case "exit":
                session.invalidate();
                response.sendRedirect("login.jsp");
                break;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Menu</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('atm2.png') no-repeat center/cover;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .atm-container {
            position: relative;
            width: 800px;
            height: 600px;
        }
.buttons-wrapper {
    position: absolute;
    top: 10%;
    left: 30%;
    transform: translateX(-50%);
    width: 100%;
    display: flex;
    justify-content: space-between;
    padding: 0 50px;
    box-sizing: border-box;
}


        .button-column {
            display: flex;
            flex-direction: column;
            gap: 30px;
            width: 45%;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 15px 25px;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: 0.3s;
            position: relative;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        button::before,
        button::after {
            content: '';
            position: absolute;
            font-size: 20px;
        }

        .left-buttons button::before {
            left: 10px;
        }

        .right-buttons button::after {
            right: 10px;
            content: '';
        }

        button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .exit-btn {
            background-color: #dc3545;
            margin-top: auto;
        }

        .exit-btn:hover {
            background-color: #c82333;
        }

        button span {
            flex-grow: 1;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="atm-container">
        <form action="main_class.jsp" method="post" class="buttons-wrapper">
            <div class="button-column left-buttons">
                <button type="submit" name="transaction" value="deposit"><span>Deposit</span></button>
                <button type="submit" name="transaction" value="withdrawal"><span>Cash Withdrawal</span></button>
                <button type="submit" name="transaction" value="fastcash"><span>Fast Cash</span></button>
                <button type="submit" name="transaction" value="ministatement"><span>Mini Statement</span></button>
            </div>
            
            <div class="button-column right-buttons">
                <button type="submit" name="transaction" value="pinchange"><span>Pin Change</span></button>
                <button type="submit" name="transaction" value="balance"><span>Balance Enquiry</span></button>
                <button type="submit" name="transaction" value="exit" class="exit-btn"><span>Exit</span></button>
            </div>
        </form>
    </div>
</body>
</html>


