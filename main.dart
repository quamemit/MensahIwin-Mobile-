import 'package:flutter/material.dart';

void main() {
  runApp(StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int studentCount = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Profile Picture URL
  String profileUrl =
      "https://www.w3schools.com/w3images/avatar2.png"; // replace with your own

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Info Manager")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // a. Welcome Dashboard
            Text(
              "Name: Your Name\nCourse: BSc. IT\nUniversity: UENR",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Arial'),
            ),
            SizedBox(height: 20),

            // b. Interactive Notification
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("Hello, Your Name! Welcome to the Student Info Manager."),
                  duration: Duration(seconds: 2),
                ));
              },
              child: Text("Show Alert"),
            ),
            SizedBox(height: 20),

            // c. Student Counter
            Text("Students Enrolled: $studentCount",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        studentCount++;
                      });
                    },
                    icon: Icon(Icons.add_circle, color: Colors.green, size: 32)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (studentCount > 0) studentCount--;
                      });
                    },
                    icon: Icon(Icons.remove_circle, color: Colors.red, size: 32)),
              ],
            ),
            SizedBox(height: 20),

            // d. Student Login Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value == null || !value.contains("@")) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Login Successful for ${emailController.text}")));
                        }
                      },
                      child: Text("Login"))
                ],
              ),
            ),
            SizedBox(height: 20),

            // e. Profile Picture Display
            ClipOval(
              child: Image.network(
                profileUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}