<%@ include file="dbConnection.jsp" %> <!-- Including the dbConnection file -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Form</title>
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
        <h1>Signup Form</h1>
        <form action="signup.jsp" method="post">
            <h3>Application Form No: <%= Math.abs(Math.floor(Math.random() * 9000) + 1000) %></h3>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="fname">Father's Name:</label>
                <input type="text" id="fname" name="fname" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label>Gender:</label>
                <input type="radio" id="male" name="gender" value="Male" required> Male
                <input type="radio" id="female" name="gender" value="Female" required> Female
            </div>
            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Marital Status:</label>
                <input type="radio" id="married" name="marital" value="Married" required> Married
                <input type="radio" id="unmarried" name="marital" value="Unmarried" required> Unmarried
                <input type="radio" id="other" name="marital" value="Other" required> Other
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" required>
            </div>
            <div class="form-group">
                <label for="pin">Pin Code:</label>
                <input type="text" id="pin" name="pin" required>
            </div>
            <div class="form-group">
                <label for="state">State:</label>
                <input type="text" id="state" name="state" required>
            </div>
            <div class="form-actions">
                <button type="submit">Submit</button>
                <button type="button" class="login-button" onclick="window.location.href='login.jsp'">Login</button>
                 <a href="index.html">Home </a>
            </div>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String formno = String.valueOf(Math.abs(Math.floor(Math.random() * 9000) + 1000));
            String name = request.getParameter("name");
            String fname = request.getParameter("fname");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String marital = request.getParameter("marital");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String pincode = request.getParameter("pin");
            String state = request.getParameter("state");

            // Check for empty fields
            if (name.isEmpty() || fname.isEmpty() || dob.isEmpty() || gender == null || email.isEmpty() || marital == null || address.isEmpty() || city.isEmpty() || pincode.isEmpty() || state.isEmpty()) {
                out.println("<h3>Error: All fields are required!</h3>");
            } else {
                // Prepare SQL Query for Inserting Data into Database
                String query = "INSERT INTO signup(form_no, name, father_name, DOB, gender, email, martial_status, address, city, pincode, state) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try {
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, formno);
                    stmt.setString(2, name);
                    stmt.setString(3, fname);
                    stmt.setString(4, dob);
                    stmt.setString(5, gender);
                    stmt.setString(6, email);
                    stmt.setString(7, marital);
                    stmt.setString(8, address);
                    stmt.setString(9, city);
                    stmt.setString(10, pincode);
                    stmt.setString(11, state);

                    // Execute the query
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<h3>Signup Successful!</h3>");
                        response.sendRedirect("signup2.jsp"); // Redirect to the next page after success
                    } else {
                        out.println("<h3>Error: Unable to signup. Please try again later.</h3>");
                    }
                } catch (SQLException e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                }
            }
        }
    %>
</body>
</html>
