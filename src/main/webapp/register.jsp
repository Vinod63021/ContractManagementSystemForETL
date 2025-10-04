<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register</title>
  <link rel="stylesheet" href="css/register.css" />
</head>
<body>
  <div class="container">
    <div class="form-box">
      <!-- Logo -->
      <div class="logo-container">
        <img src="images/logo.png" alt="App Logo" class="logo">
      </div>

      <h2>Register</h2>

      <form action="register" method="post" id="register-form">
        <div class="form-group">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name" placeholder="Your Name" required>
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" placeholder="Your Email" required>
        </div>

        <div class="form-group">
          <label for="pass">Password</label>
          <input type="password" id="pass" name="pass" placeholder="Password" required>
        </div>

        <div class="form-group">
          <label for="re_pass">Repeat Password</label>
          <input type="password" id="re_pass" name="re_pass" placeholder="Repeat your password" required>
        </div>

        <div class="form-group">
          <label for="contact">Contact No</label>
          <input type="text" id="contact" name="contact" placeholder="Contact Number" required>
        </div>
        
        <div class="form-group">
  		<label for="role">Role</label>
  		<select id="role" name="role" required>
    		<option value="" disabled selected>--Choose a role--</option>
    		<option value="ELC">ELC Contract</option>
    		<option value="Cell">ELC Contract Cell</option>
    		<option value="Incharge">Zone Incharge</option>
    		<option value="Coordinator">Zone Coordinator</option>
    		<option value="Engineer">Service Engineer</option>
  		</select>
		</div>

        <div class="form-group checkbox">
          <input type="checkbox" id="agree-term" name="agree-term" required>
          <label for="agree-term">I agree to the <a href="#">Terms of Service</a></label>
        </div>

        <button type="submit" class="btn">Register</button>
        <p class="alt-link">Already have an account? <a href="login.jsp">Login</a></p>
        
        
      <% String status = (String) request.getAttribute("status"); %>
      <% if ("success".equals(status)) { %>
        <p style="color: green;">Registration successful! <a href="login.jsp">Login here</a></p>
      <% } else if ("failed".equals(status)) { %>
        <p style="color: red;">Registration failed. Please try again.</p>
      <% } %>
        
      </form>
    </div>
  </div>
</body>
</html>
