const loginBtn = document.getElementById('loginBtn');
const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');
const errorAlert = document.getElementById('errorAlert');

async function login() {
    const username = usernameInput.value.trim();
    const password = passwordInput.value;

    errorAlert.classList.add('d-none');
    loginBtn.disabled = true;

    try {
        const response = await fetch('api/login.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });
        const result = await response.json();

        if (!response.ok) {
            throw new Error(result.error || 'Login failed.');
        }

        // The PHP session stores the authenticated user for the dashboard.
        if (result.username) {
            window.location.href = 'dashboard.html';
        } else {
            throw new Error('The server returned an invalid login response.');
        }
    } catch (error) {
        errorAlert.textContent = error.message;
        errorAlert.classList.remove('d-none');
    } finally {
        loginBtn.disabled = false;
    }
}

loginBtn.addEventListener('click', login);

passwordInput.addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
        login();
    }
});