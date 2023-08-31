import 'package:ambutracker/global/global.dart';
import 'package:ambutracker/mainScreen/main_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  List<String> selectedTools = [];

  List<String> resourceList = [
    "Ambulance",
    "Oxygen",
    "Medicine",
    "Plasma",
    "Hospital Bed",
    "ECG",
    "Ventilator",
    "Blood",
    "Defibrillator",
    "Others"
  ];

  Map<String, bool> createToolsMap(List<String> selectedTools) {
    Map<String, bool> map = {};
    for (String tool in selectedTools) {
      map[tool] = true;
    }
    return map;
  }
  Map<String, bool> toolsMap = {};
  saveCarInfo() {
    Map carToolsMap = {
      "selected_tools": selectedTools
    };
    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(carToolsMap);

    Fluttertoast.showToast(msg: "Your account info has been saved.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/ambulance.png")
              ),
        
              const SizedBox(height: 16),
              const Text(
                "Ambulance Details",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),

              MultiSelectDialogField(
                items: resourceList.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  selectedTools = values;
                },
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                buttonText: const Text(
                  "Resources Offered",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () {
                  if(selectedTools.isNotEmpty) {
                    saveCarInfo();
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
                  }
                  else {
                    Fluttertoast.showToast(msg: "Please select at least one resource", textColor: Colors.red, fontSize: 14);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )        
      )
    );
  }
}