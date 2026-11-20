function setGreeting(username) {
    const hour = new Date().getHours();
    let greetingText = 'Good evening';

    if (hour < 12) {
        greetingText = 'Good morning';
    } else if (hour < 18) {
        greetingText = 'Good afternoon';
    }

    const greeting = document.getElementById('greeting');
    const usernameDisplay = document.getElementById('usernameDisplay');
    usernameDisplay.textContent = username;
    greeting.replaceChildren(document.createTextNode(greetingText + ', '), usernameDisplay);
}

function updateStatistics(stats) {
    document.getElementById('stat1-value').textContent = Number(stats.steps_today).toLocaleString();
    document.getElementById('stat2-value').textContent = Number(stats.calories_burned).toLocaleString() + ' kcal';
    document.getElementById('stat3-value').textContent = stats.workouts_this_week;
    document.getElementById('stat4-value').textContent = stats.avg_heart_rate + ' bpm';
}

function populateActivityTable(activities) {
    const tableBody = document.getElementById('activityTableBody');
    tableBody.replaceChildren();

    activities.forEach(function (activity) {
        const row = document.createElement('tr');
        const date = new Date(activity.workout_date + 'T00:00:00');
        const values = [
            date.toLocaleDateString('en-US', { month: 'short', day: '2-digit', year: 'numeric' }),
            activity.workout,
            activity.duration_minutes + ' min',
            activity.calories + ' kcal'
        ];

        values.forEach(function (value) {
            const cell = document.createElement('td');
            cell.textContent = value;
            row.appendChild(cell);
        });

        const statusCell = document.createElement('td');
        const badge = document.createElement('span');
        badge.className = 'badge ' + (activity.status === 'Completed' ? 'badge-success-custom' : 'badge-danger-custom');
        badge.textContent = activity.status;
        statusCell.appendChild(badge);
        row.appendChild(statusCell);
        tableBody.appendChild(row);
    });
}

document.getElementById('logoutBtn').addEventListener('click', async function () {
    await fetch('api/logout.php', { method: 'POST' });
    window.location.href = 'index.html';
});

async function loadDashboard() {
    const errorBox = document.getElementById('dashboardError');

    try {
        const response = await fetch('api/dashboard.php');
        const result = await response.json();

        if (response.status === 401) {
            window.location.href = 'index.html';
            return;
        }
        if (!response.ok) {
            throw new Error(result.error || 'Unable to load dashboard data.');
        }

        setGreeting(result.username);
        updateStatistics(result.stats);
        populateActivityTable(result.activities);
    } catch (error) {
        errorBox.textContent = error.message;
        errorBox.classList.remove('d-none');
    }
}

loadDashboard();