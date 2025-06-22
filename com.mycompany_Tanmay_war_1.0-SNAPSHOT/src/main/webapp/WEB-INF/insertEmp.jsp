<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Level, java.util.logging.Logger" %>
<%
    Logger LOGGER = Logger.getLogger("AddEmployeeLogger");

    String first_Name = request.getParameter("first_name");
    String last_Name = request.getParameter("last_name");
    String department = request.getParameter("department");
    String position = request.getParameter("position");
    String salaryStr = request.getParameter("salary");

    if (first_Name == null || last_Name == null || department == null || position == null || salaryStr == null ||
        first_Name.trim().isEmpty() || last_Name.trim().isEmpty() || department.trim().isEmpty() || position.trim().isEmpty() || salaryStr.trim().isEmpty()) {
        out.println("<h3>Error: All fields are required.</h3>");
        return;
    }

    double salary;
    try {
        salary = Double.parseDouble(salaryStr);
    } catch (NumberFormatException e) {
        out.println("<h3>Error: Invalid salary format.</h3>");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/world?useSSL=false&allowPublicKeyRetrieval=true";
    String dbUser = "root"; 
    String dbPassword = "pr@sh@nt777777";// Use environment variable

    String sql = "INSERT INTO employeees (first_name, last_name, department, position, salary) VALUES (?, ?, ?, ?, ?)";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, first_Name);
            preparedStatement.setString(2, last_Name);
            preparedStatement.setString(3, department);
            preparedStatement.setString(4, position);
            preparedStatement.setDouble(5, salary);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<h3>Employee added successfully!</h3>");
            } else {
                out.println("<h3>Failed to add employee. Please try again.</h3>");
            }
        }
    } catch (ClassNotFoundException e) {
        out.println("<h3>Error: MySQL Driver not found!</h3>");
      
    } catch (SQLException e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>"); // Display SQL error message
        LOGGER.log(Level.SEVERE, "Database error while adding employee", e);
    }
%>
