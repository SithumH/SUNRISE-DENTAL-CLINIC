# Sunrise Dental Clinic Management System

Sunrise Dental Clinic Management System is a Java web application for patient registration, appointment scheduling, clinic staff workflows, treatment management, and billing. The application is packaged as a WAR and uses Jakarta Servlets/JSP for requests and pages, JDBC for persistence, and MySQL for storage.

## What the application does

### Patient

- Register with a name, email, phone number, and password, then sign in.
- Choose a treatment and request an appointment for a date and time.
- View appointments belonging to the signed-in patient.
- Appointment dates in the past and missing treatment selections are rejected by the appointment handler.

### Staff

- Create a staff account and sign in.
- Register appointments for a patient by entering the patient's name, date, time, and treatment. These staff-created appointments do not require a linked patient account.
- View the clinic's appointment list.
- Enter a bill amount for an appointment, update its status to `Billed`, and open a printable bill page.

### Admin

- Sign in with credentials currently hard-coded in `AdminLoginServlet`.
- View and delete appointments, patients, and staff.
- Add and delete treatments.
- Open a report page populated with the appointment list.

### Appointment and treatment behavior

New appointments are saved with status `Pending` and a zero bill amount. The selected treatment's name and price are copied into the appointment when it is created. Staff billing accepts a manually entered positive amount; it does not automatically calculate the bill from the treatment fee.

## Technology

- Java Servlets using Jakarta Servlet 6.0 and JSP 3.1/JSTL 3
- MySQL with MySQL Connector/J 8.0.33
- Maven WAR packaging
- JSP, HTML, CSS, and browser-side JavaScript

## Requirements

- JDK 11 or later
- Maven
- MySQL Server
- A compatible Jakarta servlet/JSP container, such as Apache Tomcat 10.1

`pom.xml` compiles the Java source to Java 8 bytecode. The servlet container itself must support the Jakarta APIs used by the application; Tomcat 9 and earlier use the older `javax.*` APIs and are not compatible without migration.

## Run locally

The commands below assume a MySQL command-line client, Maven, and Tomcat are installed. Run database and Maven commands from the `HealthSystem` directory.

1. **Create and seed the database:**

   ```sh
   mysql -u root -p -P 3307 < database.sql
   ```

   The script creates the `healthsystem` database, tables, five sample treatments, two sample staff users, and one sample patient. It uses `INSERT IGNORE` for seeded rows.

2. **Configure MySQL.** Edit `src/main/java/com/health/util/DBConnection.java` to match the local MySQL host, port, database name, username, and password. Its current defaults are `localhost:3307/healthsystem`, user `root`, and an empty password.

3. **Build the WAR:**

   ```sh
   mvn clean package
   ```

   The output is `target/HealthSystem-1.0.war`.

4. **Deploy to Tomcat.** Copy the WAR to Tomcat's `webapps` directory and start Tomcat. With the default WAR name and port, the application URL is:

   ```text
   http://localhost:8080/HealthSystem-1.0/
   ```

   Tomcat chooses the default context path from the WAR filename; it changes if you rename the WAR or configure another context.

## Demo accounts

The seed script provides the following accounts:

| Role | Email | Password |
|---|---|---|
| Admin | `admin@health.com` | `admin123` |
| Staff | `saman@health.com` | `staff123` |
| Staff | `dilani@health.com` | `staff123` |
| Patient | `amal@gmail.com` | `patient123` |

The admin credentials are hard-coded in `src/main/java/com/health/servlet/admin/AdminLoginServlet.java`; the other demo accounts are inserted by `database.sql`. These are development-only credentials. Patient and staff passwords are currently stored directly in the database, so this implementation must not be used with real patient information or exposed as a production service without security changes.

## Database structure

`database.sql` creates the following tables in the `healthsystem` schema:

| Table | Purpose and main fields |
|---|---|
| `patients` | Patient name, unique email, phone, and password |
| `staff` | Staff name, unique email, phone, role, and password |
| `treatments` | Treatment name, description, and price |
| `appointments` | Patient reference/name, treatment reference/name/fee, date, time, status, and bill amount |

The appointment table's `patient_id` foreign key is nullable and uses `ON DELETE SET NULL`, allowing an appointment to remain if its patient account is deleted. Treatment details are also copied into each appointment row, preserving the selected treatment label and fee on that appointment.

The seeded treatments are Dental Consultation (1500), Teeth Cleaning (2500), Tooth Filling (3500), Tooth Extraction (5000), and Root Canal Treatment (18000). The SQL script does not declare a currency.

## Request handlers and pages

Servlet handlers are under `src/main/java/com/health/servlet/`; role-specific JSP pages are under `src/main/webapp/`.

| Area | Handler paths | Related pages |
|---|---|---|
| Admin | `/admin/login`, `/admin/logout`, `/admin/appointments`, `/admin/patients`, `/admin/staff`, `/admin/treatments`, `/admin/reports` | `admin/login.jsp`, `admin/dashboard.jsp`, `admin/appointments.jsp`, `admin/patients.jsp`, `admin/staff.jsp`, `admin/treatments.jsp`, `admin/reports.jsp` |
| Patient | `/patient/login`, `/patient/logout`, `/patient/register`, `/patient/appointment` | `patient/login.jsp`, `patient/register.jsp`, `patient/dashboard.jsp`, `patient/appointments.jsp`, `patient/registerAppointment.jsp` |
| Staff | `/staff/login`, `/staff/logout`, `/staff/register`, `/staff/appointment`, `/staff/bill` | `staff/login.jsp`, `staff/register.jsp`, `staff/dashboard.jsp`, `staff/appointments.jsp`, `staff/registerAppointment.jsp`, `staff/calculateBill.jsp`, `staff/printBill.jsp` |

Most role-specific handler requests check for that role's session attribute and redirect unauthenticated users to the relevant login page. The home page is `index.html`; `WEB-INF/web.xml` declares it as the welcome page. The shared `js/main.js` provides sidebar toggling, basic registration/appointment/bill form validation, and bill printing.

See [`HealthSystem/ENDPOINTS.md`](HealthSystem/ENDPOINTS.md) for the existing endpoint reference. Some entries in that older file may not reflect the current servlet mappings.

### Servlet configuration caveat

`WEB-INF/web.xml` sets `metadata-complete="true"`, which prevents the container from discovering the `@WebServlet` annotations used by some handlers. The descriptor does not explicitly map `/admin/treatments` or `/admin/reports`, even though those handlers exist in the source. It also declares `com.health.servlet.admin.AdminDoctorServlet`, for which there is no corresponding source file in this repository. Before relying on those admin routes or deploying to a container that validates declared servlets at startup, reconcile the descriptor with the servlet source (for example, add the missing mappings and remove or implement the stale doctor servlet declaration).

## Source layout

```text
HealthSystem/
├── database.sql
├── pom.xml
├── ENDPOINTS.md
└── src/main/
    ├── java/com/health/
    │   ├── dao/          # JDBC queries and persistence
    │   ├── model/        # Patient, Staff, Treatment, Appointment
    │   ├── servlet/      # Request handlers grouped by user role
    │   └── util/         # MySQL connection helper
    └── webapp/
        ├── admin/        # Administration JSP pages
        ├── patient/      # Patient JSP pages
        ├── staff/        # Staff JSP pages
        ├── css/          # Shared stylesheet
        ├── js/           # Browser-side validation and UI behavior
        └── WEB-INF/      # Web application deployment descriptor
```
