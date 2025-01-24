<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        /* General styles */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background-color: #e5e5e5; /* Matches the blue background */
            color: #000;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-wrapper {
            width: 1200px;
            height: 650px;
            display: flex;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.5);
            background-color: #7f9bb3; /* Light gray */
        }

        /* Left section styles */
        .left {
            width: 60%;
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .left h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            color: #000;
        }

        .form-group {
            width: 100%;
            margin: 15px 0;
            position: relative;
        }

        label {
            display: block;
            font-size: 0.9em;
            margin-bottom: 5px;
        }

        input, select {
            width: 400px;
            padding: 12px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            font-size: 1.1em;
            font-weight: bold;
            color: #fff;
            background-color: #000;
            border: none;
            border-radius: 5px;
            margin-top: 15px;
            cursor: pointer;
        }

        button:hover {
            background-color: #333;
        }

        .login-footer {
            margin-top: 15px;
            font-size: 0.9em;
            color: #555;
        }

        .login-footer a {
            color: #000;
            font-weight: bold;
            text-decoration: none;
        }

        /* Right section styles */
        .right {
            width: 40%;
            background-image: url('images/1.1.jpeg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-wrapper">
        <!-- Left Section -->
        <div class="left">
            <h1>Sign Up</h1>
            <form action="signup" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <div class="form-group">
                    <label for="userType">User Type:</label>
                    <select id="userType" name="userType" required>
                        <option value="normal">Normal User</option>
                        <option value="authorized">Authorized User</option>
                    </select>
                </div>
                <button type="submit">Sign Up</button>
            </form>
            <p class="login-footer">Already have an account? <a href="login.jsp">Login</a></p>
        </div>

        <!-- Right Section -->
        <div class="right"></div>
    </div>
</div>
</body>
</html>
