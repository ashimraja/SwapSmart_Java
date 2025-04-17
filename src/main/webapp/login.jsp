<%@ page import="com.swapSmart.model.User" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("./");
        return;
    }

    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<%@ include file="./components/navbar.jsp" %>
<link rel="stylesheet" type="text/css" href="./assets/css/index.css">


<div class="main">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Sign Up</title>
    <link rel="stylesheet" href="./assets/css/login.css">
  </head>
  <body>
    <%-- Alert Messages  --%>
    <div class="alert-container" style="text-align: center; margin-top: 10px;">
      <% if ("exists".equals(error)) { %>
        <div style="color: red;">User already exists with this email.</div>
      <% } else if ("failed".equals(error)) { %>
        <div style="color: red;">Failed to create account. Try again.</div>
      <% } else if ("invalid".equals(error)) { %>
        <div style="color: red;">Invalid email or password.</div>
      <% } else if ("exception".equals(error)) { %>
        <div style="color: red;">Something went wrong. Please try later.</div>
      <% } else if ("registered".equals(success)) { %>
        <div style="color: green;">Registration successful! Please log in.</div>
      <% } %>
    </div>

    <div class="login-main">
      <div class="login-container">
        <form id="authForm" class="auth-form" action="login" method="POST">
          <div class="form-header">
            <p id="formTitle" class="form-title">Login</p>
            <hr class="form-divider" />
          </div>

          <div id="nameField" class="form-field" style="display: none;">
            <input type="text" id="name" name="name" placeholder="Name" />
          </div>

          <div class="form-field">
            <input type="email" id="email" name="email" placeholder="Email" required />
          </div>

          <div class="form-field">
            <input type="password" id="password" name="password" placeholder="Password" required />
          </div>

          <div class="form-links">
            <a href="#" id="forgotPassword">Forgot your password?</a>
            <a href="#" id="toggleForm">Create account</a>
          </div>

          <button type="submit" id="submitButton">Sign In</button>
        </form>
      </div>
    </div>

    <script>
      const formTitle = document.getElementById('formTitle');
      const nameField = document.getElementById('nameField');
      const toggleForm = document.getElementById('toggleForm');
      const submitButton = document.getElementById('submitButton');
      const authForm = document.getElementById('authForm');

      toggleForm.addEventListener('click', (e) => {
        e.preventDefault();

        if (formTitle.innerText === 'Login') {
          formTitle.innerText = 'Sign Up';
          nameField.style.display = 'block';
          submitButton.innerText = 'Sign Up';
          authForm.action = 'register';
          toggleForm.innerText = 'Login Here';
        } else {
          formTitle.innerText = 'Login';
          nameField.style.display = 'none';
          submitButton.innerText = 'Sign In';
          authForm.action = 'login';
          toggleForm.innerText = 'Create account';
        }
      });

      authForm.addEventListener('submit', (e) => {
        if (nameField.style.display === 'block' && !document.getElementById('name').value) {
          alert("Name is required for Sign Up!");
          e.preventDefault();
        }
      });
    </script>

    <%@ include file="./components/footer.jsp" %>
  </body>
</div>
