// ===== HAMBURGER SIDEBAR TOGGLE =====
document.addEventListener('DOMContentLoaded', function () {
    var hamburger = document.getElementById('hamburger');
    var sidebar = document.querySelector('.sidebar');
    var overlay = document.getElementById('sidebarOverlay');

    if (hamburger && sidebar) {
        hamburger.addEventListener('click', function () {
            sidebar.classList.toggle('open');
            if (overlay) overlay.classList.toggle('active');
        });
    }
    if (overlay) {
        overlay.addEventListener('click', function () {
            sidebar.classList.remove('open');
            overlay.classList.remove('active');
        });
    }
});

// ===== FORM VALIDATION =====
function validateRegister(formId) {
    var form = document.getElementById(formId);
    var password = form.querySelector('[name="password"]');
    var confirm = form.querySelector('[name="confirmPassword"]');

    if (password && password.value.length < 5) {
        alert("Password must contain at least 5 characters.");
        return false;
    }

    if (password && confirm && password.value !== confirm.value) {
        alert("Passwords do not match!");
        return false;
    }
    return true;
}

function validateAppointment(formId) {
    var form = document.getElementById(formId);
    var date = form.querySelector('[name="date"]').value;
    var today = new Date().toISOString().split('T')[0];

    if (date < today) {
        alert("Please select a future date!");
        return false;
    }
    return true;
}

function validateBill() {
    var amount = document.getElementById('amount').value;
    if (!amount || amount <= 0) {
        alert("Please enter a valid amount!");
        return false;
    }
    return true;
}

function printBill() {
    window.print();
}
