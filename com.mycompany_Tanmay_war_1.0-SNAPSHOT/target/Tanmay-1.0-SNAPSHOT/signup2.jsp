<%@ include file="dbConnection.jsp" %> <!-- Including the database connection file -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page 2</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin: 15px 0;
        }
        label {
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-top: 5px;
        }
        .form-actions {
            text-align: center;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-right: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .login-button {
            background-color: #2196F3;
        }
        .login-button:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Signup Page 2</h1>
        <form method="POST">
            <input type="hidden" name="formno" value="<%= request.getParameter("form_no") %>">
            
            <div class="form-group">
                <label for="religion">Religion:</label>
                <select name="religion">
                    <option value="Hindu">Hindu</option>
                    <option value="Muslim">Muslim</option>
                    <option value="Sikh">Sikh</option>
                    <option value="Christian">Christian</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <select name="category">
                    <option value="General">General</option>
                    <option value="OBC">OBC</option>
                    <option value="SC">SC</option>
                    <option value="ST">ST</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="income">Income:</label>
                <select name="income">
                    <option value="Null">Null</option>
                    <option value="<1,50,000">Less than 1,50,000</option>
                    <option value="<2,50,000">Less than 2,50,000</option>
                    <option value="5,00,000">5,00,000</option>
                    <option value="Upto 10,00,000">Upto 10,00,000</option>
                    <option value="Above 10,00,000">Above 10,00,000</option>
                </select>
            </div>

            <div class="form-group">
                <label for="education">Education:</label>
                <select name="education">
                    <option value="Non-Graduate">Non-Graduate</option>
                    <option value="Graduate">Graduate</option>
                    <option value="Post-Graduate">Post-Graduate</option>
                    <option value="Doctorate">Doctorate</option>
                    <option value="Others">Others</option>
                </select>
            </div>

            <div class="form-group">
                <label for="occupation">Occupation:</label>
                <select name="occupation">
                    <option value="Salaried">Salaried</option>
                    <option value="Self-Employed">Self-Employed</option>
                    <option value="Business">Business</option>
                    <option value="Student">Student</option>
                    <option value="Retired">Retired</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="pan">PAN Number:</label>
                <input type="text" name="pan" required>
            </div>

            <div class="form-group">
                <label for="aadhar">Aadhar Number:</label>
                <input type="text" name="aadhar" required>
            </div>

            <div class="form-group">
                <label>Senior Citizen:</label>
                <input type="radio" name="scitizen" value="Yes" required> Yes
                <input type="radio" name="scitizen" value="No" required> No
            </div>

            <div class="form-group">
                <label>Existing Account:</label>
                <input type="radio" name="eAccount" value="Yes" required> Yes
                <input type="radio" name="eAccount" value="No" required> No
            </div>

            <div class="form-actions">
                <button type="submit">Submit</button>
                <button type="button" class="login-button" onclick="window.location.href='signup.jsp'">Back to Signup</button>
            </div>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String formno = request.getParameter("formno");
            String religion = request.getParameter("religion");
            String category = request.getParameter("category");
            String income = request.getParameter("income");
            String education = request.getParameter("education");
            String occupation = request.getParameter("occupation");
            String pan = request.getParameter("pan");
            String aadhar = request.getParameter("aadhar");
            String scitizen = request.getParameter("scitizen");
            String eAccount = request.getParameter("eAccount");

            // Check for empty fields
            if (pan.isEmpty() || aadhar.isEmpty()) {
                out.println("<h3>Error: PAN and Aadhar are required!</h3>");
            } else {
                // Prepare SQL Query for Inserting Data into Database
                String query = "INSERT INTO signuptwo (form_no, religion, category, income, education, occuption, pan, aadhar, seniorcitizen, existing_account) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try {
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, formno);
                    stmt.setString(2, religion);
                    stmt.setString(3, category);
                    stmt.setString(4, income);
                    stmt.setString(5, education);
                    stmt.setString(6, occupation);
                    stmt.setString(7, pan);
                    stmt.setString(8, aadhar);
                    stmt.setString(9, scitizen);
                    stmt.setString(10, eAccount);

                    // Execute the query
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<h3>Signup Successful!</h3>");
                        response.sendRedirect("signup3.jsp?formno=" + formno); // Redirect to the next page after success
                    } else {
                        out.println("<h3>Error: Unable to complete signup. Please try again later.</h3>");
                    }
                } catch (SQLException ex) {
                    out.println("<h3>Error: " + ex.getMessage() + "</h3>");
                }
            }
        }
    %>
</body>
</html>
