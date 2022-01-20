import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_light/config/routes.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/core/data_manager.dart';
import 'package:uni_light/core/match_making.dart';
import 'package:uni_light/utils/constants.dart';

const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notification",
  description: "This channel is used for important notifications",
  importance: Importance.high,
  playSound: true,
);

Future<void> firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgoundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  await Purchases.setup("goog_tOZZTviZpwAnnxrISJmrevEoqWH");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (_) => MatchMaker(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    Geofire.initialize("dates");
    context.read<Authentication>().hasService();
    context.read<Authentication>().hasPermission();
    // context.read<Authentication>().checkSub();

    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          context.read<Authentication>().getUserData().then((value) => _navigatorKey.currentState!.pushNamedAndRemoveUntil('/root', (route) => false));
        } else {
          _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
    );
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (notification != null && androidNotification != null) {
        // var notify = prefs.getStringList("notifications") ?? [];
        // Map<String, dynamic> data = {
        //   notification.android.
        // };
        // prefs.setStringList("notifications", jsonEncode(data));
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              channelDescription: androidNotificationChannel.description,
              color: Colors.blue,
              playSound: true,
              icon: "@mipmap/ic_launcher",
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (notification != null && androidNotification != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title!),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body!)
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni Light',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: kPrimaryColor,
        ),
        scaffoldBackgroundColor: kPrimaryColor,
        fontFamily: 'Poppins',
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/root',
      routes: routes,
    );
  }
}
