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



# 🛠️ Assignment 3 — Offline Support & State Management Upgrade

## 🚀 Branch Information

* **Current Extension Track:** `feature/offline-cache-and-state-manangement`

* **Previous API Sync Track:** `feature/course-api-integration`

### Packages Used

| Package | Version | Purpose |
| :--- | :--- | :--- |
| `provider` | `^6.1.2` | State management (`ChangeNotifier`) |
| `hive` + `hive_flutter` | `^2.2.3` / `^1.1.0` | Offline-first local storage engine |
| `hive_generator` + `build_runner` | `^2.0.1` / `^2.4.9` | Hive adapter code generation pipelines |
| `connectivity_plus` | `^6.0.3` | Real-time network connectivity detection |
| `http` | `^1.2.1` | REST API atomic operations |
| `shared_preferences` | `^2.2.2` | Authentication user session persistence |

---

### 🏗️ Architecture Design Model

```text
UI (Screens / Widgets)
        ↕   [Provider]
CourseController (ChangeNotifier)
        ↕
CourseRepository  🡨 decides API vs Hive
     ↙       ↘
CourseApiService    HiveCourseLocal
  (HTTP only)          (Hive box)
        ↑
ConnectivityService (stream)
```

⚠️ Strict Rule: Each architectural layer only communicates with the layer directly below it. The UI never touches the services layer or the Hive instance directly.

### 💾 Offline Strategy (Short Explanation)

Read Operations: Internet active hone par data remote API se fetch ho kar Hive database me cache hota hai. Internet drop hone par app bina crash hue instantly local Hive database memory block se backup serve karti hai.

Write Operations (Create/Sync): Offline state me create kiya gaya data Hive me pendingSync: true flag ke sath save hota hai aur connectivity re-establish hote hi syncPending() pipeline ke zariye automatic flush hokar API par update ho jata hai.

Optimistic UI Updates: Delete aur Edit actions par UI state milli-second level par instantly change ho jati hai. Agar background remote API call fail hoti hai, to automatic protective rollback sequence triggered hota hai jo data array ko safe revert karta hai.

### 🔄 State Management Approach (Short Explanation)

Provider Integration: CourseController (ChangeNotifier) pure component ecosystem ka single source of truth hai jo functional UI layout ko database/business logic se isolated rakhta hai.

State Enums & Life Cycle: Data handling models explicit status enums (ListState & ActionState) ke loading grids (loading, success, error, empty) par mapping hote hain.

Network Automation: Controller directly real-time connectivity stream ko subscribe karta hai jo online aane par data parameters auto-sync karta hai aur offline jane par dynamic alerts trigger karta hai.

### 🎨 Advanced UX Features

- Pull-to-refresh: Standard RefreshIndicator support layout framework.

- Real-time Search: Real-time query matching capability filters over course titles and descriptions.

- Shimmer Skeleton Loading: Smooth animated loader structures instead of generic progress bars.

- Offline Banner Notifications: Drop-down connection alert status bar mapping.

- Source Origin Badges: Visual tags targeting metadata context: 🌐 API, 📦 Local Cache, or ⏳ Pending Sync.

- Defensive Interaction Modals: Interactive safety alert blocks executed explicitly before database entry deletion.

- Context Empty States: Clean custom vector screens for no-search matches or missing records.


## 📸 Screenshots

###  RollBack Feature
![RollBack](/Screenshot/off-del.png)

![RollBack](/Screenshot/Rollback.png)

### Filter Screen
![Filter](/Screenshot/Filter.png)



## 🚀 How to Run
```bash
flutter pub get
flutter run
