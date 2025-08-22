import 'package:flutter/material.dart';

void main() {
  runApp(CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Dashboard',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: DashboardHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _selectedIndex = 0;
  String selectedCategory = "None";

  // Dummy course list
  final List<Map<String, dynamic>> courses = [
    {"name": "Flutter Dev", "instructor": "Mr. Kwame", "icon": Icons.phone_android},
    {"name": "Database Systems", "instructor": "Mrs. Ama", "icon": Icons.storage},
    {"name": "Networking", "instructor": "Mr. Kofi", "icon": Icons.wifi},
    {"name": "Web Development", "instructor": "Miss Afia", "icon": Icons.web},
    {"name": "AI & ML", "instructor": "Dr. Mensah", "icon": Icons.computer},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course Dashboard")),
      body: Center(
        child: _selectedIndex == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Home Page",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              )
            : _selectedIndex == 1
                ? ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(courses[index]["icon"]),
                        title: Text(courses[index]["name"]),
                        subtitle: Text("Instructor: ${courses[index]["instructor"]}"),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Profile Page",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),

                      // d. Animated Action Button
                      AnimatedScale(
                        scale: 1.2,
                        duration: Duration(seconds: 1),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Enroll in a Course"),
                        ),
                      ),
                      SizedBox(height: 20),

                      // e. Course Selection Dropdown
                      DropdownButton<String>(
                        value: selectedCategory == "None" ? null : selectedCategory,
                        hint: Text("Select Course Category"),
                        items: ["Science", "Arts", "Technology"]
                            .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text("Selected Category: $selectedCategory"),
                      SizedBox(height: 20),

                      // c. Exit Confirmation Dialog
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Logout"),
                                content: Text("Are you sure you want to exit the app?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("No")),
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text("Yes")),
                                ],
                              ),
                            );
                          },
                          child: Text("Logout"))
                    ],
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}