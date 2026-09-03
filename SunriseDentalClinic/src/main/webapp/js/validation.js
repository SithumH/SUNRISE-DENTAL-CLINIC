// Appointment form validation
function validateAppointmentForm() {
    const aptNo   = document.getElementById('appointmentNumber').value.trim();
    const name    = document.getElementById('patientName').value.trim();
    const contact = document.getElementById('contactNumber').value.trim();
    const dentist = document.getElementById('dentistName').value.trim();
    const treat   = document.getElementById('treatmentId').value;
    const date    = document.getElementById('appointmentDate').value;
    const time    = document.getElementById('appointmentTime').value;

    if (!aptNo)   return showError('Appointment number is required.');
    if (!name)    return showError('Patient name is required.');
    if (!/^\d{10}$/.test(contact)) return showError('Contact number must be exactly 10 digits.');
    if (!dentist) return showError('Dentist name is required.');
    if (!treat)   return showError('Please select a treatment.');
    if (!date)    return showError('Appointment date is required.');

    const today = new Date(); today.setHours(0,0,0,0);
    if (new Date(date) < today) return showError('Appointment date cannot be in the past.');
    if (!time)    return showError('Appointment time is required.');

    return true;
}

// Login form validation
function validateLoginForm() {
    const u = document.getElementById('username').value.trim();
    const p = document.getElementById('password').value.trim();
    if (!u) return showError('Username is required.');
    if (!p) return showError('Password is required.');
    return true;
}

function showError(msg) {
    const el = document.getElementById('clientError');
    if (el) { el.textContent = msg; el.style.display = 'block'; }
    return false;
}
