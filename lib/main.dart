import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Information',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 231, 97),
        primarySwatch: Colors.red,
      ),
      home: UserInfoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String userName = '';
  String address = '';
  String gender = '';
  DateTime dateOfBirth = DateTime.now();
  double weight = 50;
  double height = 100;

  void calculateBMI() {
    double bmi = weight / ((height / 100) * (height / 100));
    String bmiComment;

    if (bmi < 18.5) {
      bmiComment = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      bmiComment = 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      bmiComment = 'Overweight';
    } else {
      bmiComment = 'Obese';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 230, 64),
          title: Text('User Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: $userName'),
              Text('Address: $address'),
              Text('Gender: $gender'),
              Text('Date of Birth: $dateOfBirth'),
              Text('Weight: $weight kgs'),
              Text('Height: $height cms'),
              SizedBox(height: 16.0),
              Text('BMI: $bmi'),
              Text('BMI Comment: $bmiComment'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              decoration: InputDecoration(labelText: 'Address'),
            ),
            Row(
              children: [
                Text('Gender: '),
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Date of Birth'),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((value) {
                  setState(() {
                    dateOfBirth = value!;
                  });
                });
              },
              child: Container(
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore
                    Text(dateOfBirth != null
                        ? '${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}'
                        : 'Select a date'),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (in kgs)'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  height = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (in cms)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
