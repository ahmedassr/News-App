import 'package:first_app/shared/BlocObserever.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../network/remote/DioHelper.dart';
import '../../shared/cubit/cubit.dart';
import 'network/local/CashHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBool(key: 'isDark');
  runApp(MyApp(
    isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {super.key});
  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit()
                ..getBusinessData()
                ..getscience()
                ..getSport()
                ..changeMode(fromShared: isDark)),
    //      BlocProvider(
    //          create: (context) => AppCubit()..changeMode(fromShared: isDark))
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'News App',
                  theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                      scaffoldBackgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                          titleSpacing: 20,
                          systemOverlayStyle: SystemUiOverlayStyle(
                              statusBarColor: Colors.white,
                              statusBarIconBrightness: Brightness.dark),
                          backgroundColor: Colors.white,
                          titleTextStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      iconTheme: const IconThemeData(color: Colors.black),

                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      bottomNavigationBarTheme:
                          const BottomNavigationBarThemeData(
                              selectedItemColor: Colors.deepOrange,
                              unselectedItemColor: Colors.grey,
                              backgroundColor: Colors.white,
                              elevation: 10.0)),
                  darkTheme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                      scaffoldBackgroundColor: const Color(0xFF333739),

                      appBarTheme: const AppBarTheme(
                        titleSpacing: 20,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.black,
                            statusBarIconBrightness: Brightness.light),
                        backgroundColor: Color(0xFF333739),
                        elevation: 0.0,
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        iconTheme: IconThemeData(color: Colors.white),
                      ),
                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      bottomNavigationBarTheme:
                          const BottomNavigationBarThemeData(
                              selectedItemColor: Colors.deepOrange,
                              unselectedItemColor: Colors.grey,
                              backgroundColor: Color(0xFF333739))),
                  themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
                  home: const HomeLayout());
            }));
  }
}
