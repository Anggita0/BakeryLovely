# Bakery Lovely 🍰

Bakery Lovely is a mobile application developed using Flutter to demonstrate fundamental mobile application concepts, including local data management, role-based features, and location usage within a single application.

This project was created as part of the competency assessment for the **Junior Mobile Programmer** certification.

## 📱 Application Overview

Bakery Lovely is a **local-only mobile application** and is not published to any app store. The application runs directly from a development environment and requires a physical device connection for testing and usage.

The app implements two user roles within one application and focuses on correct feature flow, data processing, and functional validation.

## ✨ Features

- **Two User Roles**
  - **Admin**: manages bakery product data and receives order notifications
  - **User**: browses products and places orders

- **CRUD Operations**
  - Create, Read, Update, and Delete bakery product data
  - Implemented using a local SQLite database

- **Location Usage**
  - Captures user location when placing an order
  - Location data is used to inform the admin where the order is coming from
  - Location information is delivered as a notification to the admin within the app

- **Local Database**
  - Uses SQLite via `sqflite`
  - No external APIs or backend services

- **Functional Testing**
  - Ensures all features function correctly
  - Validates user input and application flow before presentation

## 🛠️ Tech Stack

- **Framework**: Flutter  
- **Language**: Dart  
- **Database**: SQLite (`sqflite`)  
- **Platform**: Android  
- **Deployment**: Local (not deployed to production)

## 🎯 Project Scope

This project focuses on:
- Implementing core mobile application features
- Managing local data without backend integration
- Applying location features for contextual information
- Ensuring functional correctness through testing

Bakery Lovely emphasizes proper application flow and feature validation rather than production deployment.

## 📌 Notes

- This application is not deployed or published.
- Requires a physical device connected to a development environment to run.
- Designed for learning and competency validation purposes.

---

Developed as part of a mobile application development learning and certification process.
