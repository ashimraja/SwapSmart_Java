<%@ page import="com.swapSmart.model.User" %>
<%@ page session="true" %>

<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser != null) {
        response.sendRedirect("./"); // Redirect to dashboard if already logged in
        return;
    }
%>

<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>

<div class="main">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Sign Up</title>
    <link rel="stylesheet" href="./assets/css/login.css">
  </head>
  <body>
    <div class="login-main">
      <div class="login-container">
        <!-- Form dynamically switches between Login and Sign Up -->
        <form id="authForm" class="auth-form" action="login" method="POST">
          <div class="form-header">
            <p id="formTitle" class="form-title">Login</p>
            <hr class="form-divider" />
          </div>

          <!-- Name field (visible only for Sign Up) -->
          <div id="nameField" class="form-field" style="display: none;">
            <input type="text" id="name" name="name" placeholder="Name" />
          </div>

          <!-- Email field -->
          <div class="form-field">
            <input type="email" id="email" name="email" placeholder="Email" required />
          </div>

          <!-- Password field -->
          <div class="form-field">
            <input type="password" id="password" name="password" placeholder="Password" required />
          </div>

          <!-- Toggle between Login and Sign Up -->
          <div class="form-links">
            <a href="#" id="forgotPassword">Forgot your password?</a>
            <a href="#" id="toggleForm">Create account</a>
          </div>

          <!-- Submit button -->
          <button type="submit" id="submitButton">Sign In</button>
        </form>
      </div>
    </div>

    <script>
      // JavaScript to toggle between Login and Sign Up
      const formTitle = document.getElementById('formTitle');
      const nameField = document.getElementById('nameField');
      const toggleForm = document.getElementById('toggleForm');
      const submitButton = document.getElementById('submitButton');
      const authForm = document.getElementById('authForm');
      
      toggleForm.addEventListener('click', (e) => {
        e.preventDefault();
        
        if (formTitle.innerText === 'Login') {
          formTitle.innerText = 'Sign Up';
          nameField.style.display = 'block';  // Show the name field for Sign Up
          submitButton.innerText = 'Sign Up';
          authForm.action = 'register'; // Change action to 'register' for sign-up
          toggleForm.innerText = 'Login Here';
        } else {
          formTitle.innerText = 'Login';
          nameField.style.display = 'none'; // Hide the name field for Login
          submitButton.innerText = 'Sign In';
          authForm.action = 'login'; // Change action back to 'login' for login
          toggleForm.innerText = 'Create account';
        }
      });

      // Prevent form from submitting if the name field is required but hidden
      authForm.addEventListener('submit', (e) => {
        if (nameField.style.display === 'block' && !document.getElementById('name').value) {
          alert("Name is required for Sign Up!");
          e.preventDefault();  // Prevent form submission
        }
      });
    </script>
  </body>
  <%@ include file="./components/footer.jsp" %>
</div>
