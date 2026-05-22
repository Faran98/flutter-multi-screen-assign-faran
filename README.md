# Flutter Multi-Screen Application

## 👨‍🎓 Student Info
Name: Faran Khalil  
ID: SE221057  

---

## 📱 Features
- User Registration with validation
- Login system with Remember Me
- Dashboard with subjects
- Detail screen for subjects
- Clean UI with Flutter

---

## 📸 Screenshots

### Register Screen
![Register](/Screenshot/Register.png)

### Login Screen
![Login](/Screenshot/Screenshot%202026-05-11%20231148.png)

### Dashboard
![Dashboard](/Screenshot/Screenshot%202026-05-11%20231242.png)

### Detail Screen
![Detail](/Screenshot/Screenshot%202026-05-11%20231555.png)

---

## Assignment 2 - REST API CRUD Integration

### Branch
`feature/course-api-integration`

## 📸 Screenshots

### Updated Dahboard Screen
![Dashboard2](/Screenshot/dashboard updated.png)

### Courses Screen
![Courses](/Screenshot/dashboard-updated.png)

### Create Courses
![Create](/Screenshot/add-course.png)
![Create](/Screenshot/added-course.png)

### Edit Screen
![Edit](/Screenshot/update-course.png)

### Read 
![Read](/Screenshot/read-course.png)

### Delete
![Detete](/Screenshot/delete-course.png)
![Detete](/Screenshot/deleted-course.png)


### API Used
**JSONPlaceholder** - Free fake REST API for testing
- Base URL: `https://jsonplaceholder.typicode.com/posts`
- Documentation: https://jsonplaceholder.typicode.com/guide

### Features Implemented
- **GET** - Fetch list of courses from API with loading indicator
- **POST** - Add new course via API
- **PUT** - Update existing course via API (form pre-filled)
- **DELETE** - Delete course with confirmation dialog
- Error state handling with retry option
- Separate service layer (`CourseService`) for all API calls
- Controller layer (`CourseController`) to keep UI clean



## 🚀 How to Run
```bash
flutter pub get
flutter run
