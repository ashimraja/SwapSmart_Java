<link rel="stylesheet" type="text/css" href="../assets/css/index.css">
<%@ include file="../components/navbar.jsp" %>
<div class="main">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Sign Up</title>
    <link rel="stylesheet" href="../assets/css/login.css">
</head>
<body>
<div class="login-main">
    <div class="login-container">
        <form id="authForm" class="auth-form" action="#" method="POST">
            <div class="form-header">
                <p id="formTitle" class="form-title">Login</p>
                <hr class="form-divider" />
            </div>

            <!-- Name field (visible only for Sign Up) -->
            <div id="nameField" class="form-field" style="display: none;">
                <input type="text" id="name" name="name" placeholder="Name" required />
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
        const forgotPassword = document.getElementById('forgotPassword');

        toggleForm.addEventListener('click', (e) => {
            e.preventDefault();
            if (formTitle.innerText === 'Login') {
                formTitle.innerText = 'Sign Up';
                nameField.style.display = 'block';
                submitButton.innerText = 'Sign Up';
                toggleForm.innerText = 'Login Here';
            } else {
                formTitle.innerText = 'Login';
                nameField.style.display = 'none';
                submitButton.innerText = 'Sign In';
                toggleForm.innerText = 'Create account';
            }
        });

        // Simulate form submission
        const authForm = document.getElementById('authForm');
        authForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const formData = new FormData(authForm);
            const data = Object.fromEntries(formData.entries());
            alert(`Form submitted:\n${JSON.stringify(data, null, 2)}`);
        });
    </script>
</body>
<%@ include file="../components/footer.jsp" %>
</div>