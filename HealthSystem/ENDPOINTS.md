# HealthSystem - Endpoint Mapping

**Base URL:** `http://localhost:8080/HealthSystem-1.0`

---

## Admin Endpoints

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/admin/login.jsp` | Login page | No |
| POST | `/admin/login` | Login submit | No |
| GET | `/admin/logout` | Logout | Yes |
| GET | `/admin/appointments` | All appointments | Yes |
| GET | `/admin/appointments?action=delete&id={id}` | Delete appointment | Yes |
| GET/POST | `/admin/doctors` | Manage doctors | Yes |
| GET/POST | `/admin/patients` | Manage patients | Yes |
| GET/POST | `/admin/staff` | Manage staff | Yes |

> Credentials: `admin@health.com` / `admin123`

---

## Patient Endpoints

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/patient/login.jsp` | Login page | No |
| POST | `/patient/login` | Login submit | No |
| GET | `/patient/register.jsp` | Register page | No |
| POST | `/patient/register` | Register submit | No |
| GET | `/patient/logout` | Logout | Yes |
| GET | `/patient/appointment` | My appointments | Yes |
| GET | `/patient/appointment?action=new` | New appointment form | Yes |
| POST | `/patient/appointment` | Book appointment | Yes |

---

## Staff Endpoints

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/staff/login.jsp` | Login page | No |
| POST | `/staff/login` | Login submit | No |
| GET | `/staff/register.jsp` | Register page | No |
| POST | `/staff/register` | Register submit | No |
| GET | `/staff/logout` | Logout | Yes |
| GET | `/staff/appointment` | All appointments | Yes |
| GET | `/staff/appointment?action=new` | New appointment form | Yes |
| POST | `/staff/appointment` | Register appointment | Yes |
| GET | `/staff/bill?id={id}` | Calculate bill form | Yes |
| POST | `/staff/bill` | Submit bill | Yes |

---

## Static Pages

| URL | Description |
|-----|-------------|
| `/index.html` | Home page |
| `/admin/dashboard.jsp` | Admin dashboard |
| `/patient/dashboard.jsp` | Patient dashboard |
| `/staff/dashboard.jsp` | Staff dashboard |

---

## Query Parameters

| Parameter | Used In | Description |
|-----------|---------|-------------|
| `msg=invalid` | Login pages | Invalid credentials |
| `msg=error` | Register/Appointment pages | Validation error |
| `msg=registered` | Login pages | Registration success |
| `msg=success` | Appointment pages | Booking success |
| `msg=deleted` | Admin appointments | Delete success |
| `action=new` | Appointment pages | Show new form |
| `action=delete` | Admin appointments | Delete record |
| `id={id}` | Bill / Delete | Record ID |
