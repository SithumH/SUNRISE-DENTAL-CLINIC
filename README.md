# Sunrise Dental Clinic Management System

A Java web application for managing dental clinic patients, appointments, treatments, staff, and bills. The application uses Jakarta Servlets and JSP for its web interface, MySQL for data storage, and Maven to build a deployable WAR file.

## Features

- **Patients:** Create an account, sign in, book appointments for available treatments, and view their appointments.
- **Staff:** Register and sign in, create appointments for patients, view appointments, and calculate and print bills.
- **Administration:** Sign in to manage appointments, patients, staff, and treatments.
- **Treatments:** Store treatment descriptions and fees in the database; the database script inserts several sample treatments.

## Technology

- Java web application using Jakarta Servlets and JSP/JSTL
- MySQL with MySQL Connector/J
- Maven WAR packaging
- HTML, CSS, and JavaScript for the browser interface

## Requirements

- JDK 11 or later
- Maven
- MySQL Server
- A Jakarta-compatible servlet container supporting Servlet 6.0 and JSP 3.1, such as Apache Tomcat 10.1

The Maven compiler targets Java 8 bytecode; the newer JDK requirement is for running a compatible servlet container.

## Setup

1. **Create and seed the database.** From the `HealthSystem` directory, run the included SQL script with the MySQL command-line client:

   ```sh
   mysql -u root -p -P 3307 < database.sql
   ```

   The script creates the `healthsystem` database and its tables, then inserts sample treatments, staff, and a patient. The port shown matches the application's current database connection settings.

2. **Configure the database connection.** The connection URL, username, and password are currently defined in `HealthSystem/src/main/java/com/health/util/DBConnection.java`. By default, the application connects to `localhost:3307`, database `healthsystem`, as MySQL user `root` with an empty password. Update these values to match your local MySQL configuration.

3. **Build the WAR.** From the `HealthSystem` directory:

   ```sh
   mvn clean package
   ```

   Maven writes `HealthSystem/target/HealthSystem-1.0.war`.

4. **Deploy and run.** Copy the WAR into your servlet container's deployment directory (for Tomcat, `webapps`). Start the container and open:

   ```text
   http://localhost:8080/HealthSystem-1.0/
   ```

   The context path may differ if you rename the WAR or configure a different deployment context.

## Demo accounts

The admin login is currently hard-coded in `AdminLoginServlet` as `admin@health.com` / `admin123`. The SQL seed script creates staff accounts `saman@health.com` and `dilani@health.com` with password `staff123`, and a patient account `amal@gmail.com` with password `patient123`.

These are demo credentials, not suitable for a production deployment. In particular, change the hard-coded admin credentials and replace the sample account data before exposing the application.

## Project layout

```text
HealthSystem/
├── database.sql
├── pom.xml
├── ENDPOINTS.md
└── src/main/
    ├── java/com/health/
    │   ├── dao/          # Database access
    │   ├── model/        # Patient, staff, appointment, and treatment models
    │   ├── servlet/      # Admin, patient, and staff request handlers
    │   └── util/         # MySQL connection helper
    └── webapp/
        ├── admin/        # Admin JSP pages
        ├── patient/      # Patient JSP pages
        ├── staff/        # Staff JSP pages
        ├── css/
        ├── js/
        └── WEB-INF/
```

See [`HealthSystem/ENDPOINTS.md`](HealthSystem/ENDPOINTS.md) for the documented endpoint mapping.
