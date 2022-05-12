import 'package:driver/global/global.dart';
import 'package:driver/mainScreens/main_screen.dart';
import 'package:driver/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModeltextEditingController = TextEditingController();
  TextEditingController carNumberEditingController = TextEditingController();
  TextEditingController carColortextEditingController = TextEditingController();
  List<String> carTypesList = ["uber-x", "uber-go", "bike"];
  String? SelectedCarType;
  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColortextEditingController.text.trim(),
      "car_number": carNumberEditingController.text.trim(),
      "car_model": carModeltextEditingController.text.trim(),
      "type": SelectedCarType,
    };
    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);
    Fluttertoast.showToast(msg: "Car details has been saved");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo1.png"),
            ),
            SizedBox(height: 10),
            const Text(
              "Write Car Details",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.grey,
              ),
              controller: carModeltextEditingController,
              decoration: const InputDecoration(
                labelText: "Car Model",
                hintText: 'Car Model',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.grey,
              ),
              controller: carNumberEditingController,
              decoration: const InputDecoration(
                labelText: "Car Number",
                hintText: 'Car Number',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.grey,
              ),
              controller: carColortextEditingController,
              decoration: const InputDecoration(
                labelText: "Car Color",
                hintText: 'Car Color',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButton(
              iconSize: 20,
              icon: Icon(Icons.car_repair_sharp),
              dropdownColor: Colors.black,
              hint: const Text(
                "Please choose car type",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              value: SelectedCarType,
              onChanged: (newValue) {
                setState(() {
                  SelectedCarType = newValue.toString();
                });
              },
              items: carTypesList.map((car) {
                return DropdownMenuItem(
                  child: Text(
                    car,
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: car,
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (carColortextEditingController.text.isNotEmpty &&
                      carNumberEditingController.text.isNotEmpty &&
                      carModeltextEditingController.text.isNotEmpty &&
                      SelectedCarType != null) {
                    saveCarInfo();
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
                child: const Text(
                  "Save Now",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ))
          ],
        ),
      )),
    );
  }
}
