# NutriAI App

## Function

### 1. User Initialization
- Login with UserID
- Input user information

<img width="250" src="https://user-images.githubusercontent.com/64734692/163331804-6f1d2726-1f9b-4f99-8605-0f8400473257.png"
     title="login">
<img width="250" src="https://user-images.githubusercontent.com/64734692/163331817-f14fb6aa-4205-4212-9def-e7fce4d8c175.png"
     title="input user info">


### 2. Log user's diet
- Take photos from the gallery
- Select detailed menu with toggle button
- Display the macronutrient intake for the day with bar charts

### 3. Analyze user's diet
- Provide daily/weekly report on user's nutritional status with bar chart (total 34 nutrients)

### 4. Recommend nutrients supplements based on user's nutritional status
- Display 3 product in each vitamin, mineral, amino acids category
- Hyperlink to Iherb product page

### 5. Check user information
- Display user information on the mypage

## Details

<details>
  <summary>Click to see directory tree!</summary>
  
```
lib
├── CustomDesign
│   ├── customColor.dart
│   └── customIcon.dart
├── Input_UserInfo.dart
├── MainScreens
│   ├── analyze
│   │   ├── analyze.dart
│   │   ├── daily_report.dart
│   │   └── weekly_report.dart
│   ├── foodLog
│   │   ├── food_log.dart
│   │   └── inference.dart
│   ├── mypage.dart
│   └── recommend.dart
├── generated_plugin_registrant.dart
├── home_page.dart
├── json
│   ├── RDI.dart
│   ├── UserInfo.dart
│   ├── UserSignUpInfo.dart
│   ├── nutriRecommend.dart
│   ├── nutriStat.dart
│   └── physique.dart
└── main.dart
```
</details>

 ### main.dart
 Main app resides here.
 
 ### home_page.dart
Consists of bottom navigation bar of MainScreen which is divided by four functions.

### MainScreens
- foodLog
     - food_log.dart: Daily intake of macronutrients & menu are displayed.
     - inference.dart: Category of menus are inferred from the image user selected. List of detailed categories are given to user.
- analyze
     - daily_report.dart: Daily intake of 34 nutrients are displayed.
     - weekly_report.dart: Average intake of 34 nutrients for a week are displayed.
- recommend.dart: Recommended nutritional supplements are displayed 3 in 3 categories(vitamin, mineral, amino acid) based on the user's weekly nutritional status.
- mypage.dart: Information entered by user when registering is displayed.

### json
Http responses are parsed by designating the name of attributes.
- RDI.dart
- UserInfo.dart
- UserSignUpInfo.dart
- nutriRecommend.dart
- nutriStat.dart
- physique.dart

### CustomDesign
Customized color and Icon are stored.
- customColor.dart
- customIcon.dart
