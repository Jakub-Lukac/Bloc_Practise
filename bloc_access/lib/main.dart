// ignore_for_file: unused_field, unused_element

import 'package:bloc_access/logic/cubit/counter_cubit.dart';
import 'package:bloc_access/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

// BlocProvider closes provided bloc/cubit automatically
// BlocProvider.value - we have to manually close the provided bloc/cubit
// we can only dispose it inside a StateFul widget!!

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final CounterCubit _counterCubit = CounterCubit();
  final AppRouter _appRouter = AppRouter();

  @override
  void dispose() {
    //_counterCubit.close();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // passing function as pointer/argument
        // we are NOT passing the return value of function!!!
        onGenerateRoute: _appRouter.onGenerateRoute,
        /*routes: {
            "/": (context) => BlocProvider.value(
                  // no (context) => _counterCubit, because it would create 3 unique instances
                  // we only want 1 unique instance of counter cubit
                  value: _counterCubit,
                  child: const HomeScreen(
                    title: "HomeScreen",
                    color: Colors.blueAccent,
                  ),
                ),
            "/second": (context) => BlocProvider.value(
                  value: _counterCubit,
                  child: const SecondScreen(
                    title: "Second Screen",
                    color: Colors.redAccent,
                  ),
                ),
            "/third": (context) => BlocProvider.value(
                  value: _counterCubit,
                  child: const ThirdScreen(
                    title: "Third Screen",
                    color: Colors.greenAccent,
                  ),
                ),
          },*/
      ),
    );
  }
}
