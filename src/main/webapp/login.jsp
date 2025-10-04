<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login</title>
  <link rel="stylesheet" href="css/login.css"/>
  <!-- SweetAlert2 CSS and JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  
</head>
<body>
  <div class="container">
    <div class="form-box">
      <!-- Logo -->
      <div class="logo-container">
        <img src="images/logo.png" alt="App Logo" class="logo">
      </div>

      <h2>Login</h2>
      <form action="login" method="post" id="login-form">
        <div class="form-group">
          <label for="username">Email</label>
          <input type="text" id="username" name="username" placeholder="Your Email" required>
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Password" required>
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
          <input type="checkbox" id="remember-me" name="remember-me">
          <label for="remember-me">Remember me</label>
        </div>

        <button type="submit" class="btn">Login</button>
        <p class="alt-link">Don't have an account? <a href="register.jsp">Register</a></p>

       <% String status = (String) request.getAttribute("status");
   if ("failed".equals(status)) { %>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Login Failed',
            text: 'Invalid credentials. Please try again.',
            confirmButtonColor: '#d33'
        });
    </script>
<% } %>
      </form>
    </div>
  </div>
</body>
</html>
