import 'package:delivery_app/src/packages/application_bindings.dart';
import 'package:delivery_app/src/screens/routes/generate_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(const FlutterSecureStorage());

  runApp(
    const AppView(),
  );
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink("http://192.168.0.134:8000/graphql"),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: GetMaterialApp(
        title: 'Sms',
        // initialRoute: '/',
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialBinding: ApplicationBindings(),
        theme: ThemeData(
          fontFamily: 'poppins',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // home: appController.isAuthenticated.isTrue?App():Login(),
      ),
      client: client,
    );
  }
}
