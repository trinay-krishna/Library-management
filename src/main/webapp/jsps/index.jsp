<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login and Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
            margin: 0;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            display: flex;
            justify-content: center;
        }

        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .toggle-link {
            text-align: center;
            margin-top: 10px;
        }

        .toggle-link a {
            color: #007bff;
            cursor: pointer;
            text-decoration: none;
        }

        .toggle-link a:hover {
            text-decoration: underline;
        }

        .form-container {
            display: none;
        }

        .active {
            display: block;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Login / Register</h2>

    <!-- User Login Form -->
    <div id="userLoginForm" class="form-container active">
        <form action="/WTLibb/login" method="POST">
            <div class="form-group">
                <input type="text" name="userName" id="userUserName" placeholder="Enter Username" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" id="userPass" placeholder="Enter Password" required>
            </div>
            <button type="submit">Login</button>
        </form>
        <div class="toggle-link">
            <a onclick="toggleForm('userRegister')">Register</a>
        </div>
    </div>

    <!-- User Register Form -->
    <div id="userRegisterForm" class="form-container">
        <form action="/WTLibb/register" method="POST">
            <div class="form-group">
                <input type="text" name="userName" id="userRegUserName" placeholder="Enter Username" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" id="userRegPass" placeholder="Enter Password" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <div class="toggle-link">
            <a onclick="toggleForm('userLogin')">Back to Login</a>
        </div>
    </div>
    <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
    %>
    <p style="color:red; text-align:center;"> <%= error %> </p>
    <%
    }
    %>
</div>

<script>
    function toggleForm(formType) {
        const userLoginForm = document.getElementById('userLoginForm');
        const userRegisterForm = document.getElementById('userRegisterForm');

        // Hide all forms
        userLoginForm.classList.remove('active');
        userRegisterForm.classList.remove('active');

        // Show the selected form
        if (formType === 'userLogin') {
            userLoginForm.classList.add('active');
        } else if (formType === 'userRegister') {
            userRegisterForm.classList.add('active');
        }
    }
</script>

</body>
</html>
