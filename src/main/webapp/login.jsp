<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        /* General styles */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background-color: #e5e5e5 ; /* Matches the blue background */
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
            background-color: #7f9bb3;; /* Light gray */
            margin-bottom: 150px;
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

        .social-icons {
            display: flex;
            justify-content: center;
            margin: 15px 0;
        }

        .social-icons a {
            width: 40px;
            height: 40px;
            margin: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
            background-color: #fff;
            color: #000;
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .social-icons a img {
            width: 20px;
            height: 20px;
        }

        .or-divider {
            margin: 10px 0;
            font-size: 0.9em;
            color: #555;
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

        input {
            width: 400px;
            padding: 12px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding-right: 40px;
        }

        .form-group i {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            font-size: 1.2em;
            color: #555;
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
        #title{
            margin-left: 800px;
        }
        #centerOfTitle{
            margin-left: 720px;
        }

    </style>
</head>
<body>
<h1 id="title">Hello ,  Friend !</h1>
<h4 id="centerOfTitle" >Enter Your Personal Detail and Start Journey With Us....... </h4>
<div class="container">
    <div class="login-wrapper">
        <!-- Left Section -->
        <div class="left">
            <h1>Login</h1>
            <div class="social-icons">
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook"></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/732/732200.png" alt="Gmail"></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/174/174857.png" alt="LinkedIn"></a>
            </div>
            <p class="or-divider">or Use Your Account</p>
            <form action="login" method="post">
                <div class="form-group">
                    <input type="text" id="username" name="username" placeholder="UserName" required>
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="Password" required>
                    <i class="fa fa-lock"></i>
                </div>
                <button type="submit">Log In</button>
            </form>
            <p class="login-footer">Don't Have An Account? <a href="Signup.jsp">SignUp</a></p>
        </div>

        <!-- Right Section -->
        <div class="right"></div>
    </div>
</div>
</body>
</html>
