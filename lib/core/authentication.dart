// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:location/location.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:uni_light/models/user.dart';

class Authentication extends ChangeNotifier {
  /// Location data.
  Location _location = Location();
  LocationData? _locationData;

  LocationData? get locationData => _locationData;

  Users? _user;
  Users? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final Reference _storage = FirebaseStorage.instance.ref();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Map<String, dynamic> userData = {};

  int choice = -1;
  int step = 0;

  void next() {
    switch (step) {
      case 0:
        step = 1;
        break;
      case 1:
        step = 2;

        break;
      case 2:
        step = 3;

        break;
      default:
    }
    notifyListeners();
  }

  Future<void> getUserData() async {
    var user = FirebaseAuth.instance.currentUser!;
    var doc = await _userRef.doc(user.uid).get();
    _user = Users.fromMap(doc.data()!, id: doc.id);
    _firebaseMessaging.getToken().then((token) {
      if (_user?.token != null || _user?.token != token) {
        _userRef.doc(_user?.uid).set({
          "token": token
        }, SetOptions(merge: true));
      }
    });
    setLocation();
    checkSub();
    notifyListeners();
  }

  /// Sets the user's status.
  void setChoice(int index) {
    choice = index;
    notifyListeners();
  }

  void setData(Map<String, dynamic> data) {
    userData.addAll(data);
    notifyListeners();
  }

  Future<bool> userExist(String email) async {
    QuerySnapshot data = await _userRef.where("email", isEqualTo: email).get();
    if (data.size > 0) {
      return true;
    }
    return false;
  }

  void login(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    if (credential.user != null) {
      getUserData();
    }

    notifyListeners();
  }

  void checkSub() {
    try {
      Purchases.getPurchaserInfo().then(
        (purchaserInfo) {
          if (purchaserInfo.activeSubscriptions.isNotEmpty) {
            _user!.isPremium = purchaserInfo.activeSubscriptions[0] == "uni_light_499_1m";

            notifyListeners();
          }
        },
      );
    } on PlatformException {
      return;
    }
  }

  Future<bool> signUp() async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: userData["email"], password: userData["password"]);

      if (credential.user == null) {
        throw "Couldn't Register user ";
      }
      var path = "images/${credential.user!.uid}/profile";
      TaskSnapshot snapshot = await _storage.child(path).putFile(userData["photo"]);
      if (snapshot.state == TaskState.success) {
        var imageUrl = await snapshot.ref.getDownloadURL();
        var date = userData["birth_day"];
        Timestamp myTimeStamp = Timestamp.fromDate(date);

        userData.removeWhere((key, value) => key == "birth_day");
        userData.removeWhere((key, value) => key == "password");
        userData.removeWhere((key, value) => key == "photo");
        _firebaseMessaging.getToken().then((token) {
          if (token != null) {
            setData({
              "token": token
            });
          }
          // notifyListeners();
        });

        setData({
          "photo_url": imageUrl,
          "birth_day": myTimeStamp,
        });
        _user = Users.fromMap(userData);
        _userRef.doc(credential.user!.uid).set(_user!.toMap());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void hasPermission() async {
    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      } else {
        _permissionGranted = await _location.requestPermission();
      }
    }
  }

  void hasService() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    }
  }

  void setLocation() async {
    _locationData = await _location.getLocation();

    Geofire.setLocation(_user!.uid!, _locationData!.latitude!, _locationData!.longitude!);
  }

  void disposed() {
    choice = -1;
    step = 0;
    userData = {};
  }
}
