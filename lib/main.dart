import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/screens/notification_service.dart';
import 'package:test1/screens/zoom_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test1/services/MyFirebaseMessagingService.dart';


import 'screens/account_type_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Ensure background messages are handled before Firebase is initialized
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp();
  MyFirebaseMessagingService();
  await NotificationService.init(); // Initialize Local Notifications

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ZoomProvider()), // Load zoom settings per user
      ],
      child: MyApp(),
    ),
  );
}

// 🔹 Background message handler (Runs when app is in background or terminated)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔹 Handling background message: ${message.messageId}");
  print("Message data: ${message.data}"); //Check if data is coming through
  await NotificationService.showNotification( // Assuming NotificationService can handle background notifications
    title: message.notification?.title ?? "Background Message",
    body: message.notification?.body ?? message.data.toString(),
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging(); // ✅ Initialize Firebase Messaging properly
  }

  // 🔹 Firebase Messaging Setup
  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ✅ Request notification permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ User granted permission for notifications.");
    } else {
      print("❌ User denied notification permission.");
    }

    // ✅ Set up foreground notifications (So notifications show even when app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 New Foreground Notification: ${message.notification?.title}");
      print("📝 Body: ${message.notification?.body}");

      NotificationService.showNotification(
        title: message.notification?.title ?? "New Notification",
        body: message.notification?.body ?? "",
      );
    });

    // ✅ Handle notification clicks when app is in background & clicked
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔔 Notification clicked! ${message.data}");
      // TODO: Navigate user to specific screen based on message data
    });

    // ✅ Get the FCM Token for this device (Use this to send test notifications)
    String? token = await messaging.getToken();
    print("🔑 FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomProvider>(
      builder: (context, zoomProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Care4Me',
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 16 * zoomProvider.scaleFactor),
              titleLarge: TextStyle(fontSize: 24 * zoomProvider.scaleFactor),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFF308A99), // Change cursor color
              selectionHandleColor: Color(0xFF308A99), // Change the color of the ball
              selectionColor: Color(0x55308A99), // Optional: highlight color when selecting text
            ),
          ),
          initialRoute: '/accountTypeScreen',
          routes: {
            '/accountTypeScreen': (context) => AccountTypeScreen(),
          },
        );
      },
    );
  }
}
