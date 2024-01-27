// ignore_for_file: unused_field, unused_element

import 'package:bloc_maintaining_state/logic/cubit/counter_cubit.dart';
import 'package:bloc_maintaining_state/logic/cubit/internet_cubit.dart';
import 'package:bloc_maintaining_state/logic/cubit/settings_cubit.dart';
import 'package:bloc_maintaining_state/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //setting up storage for Hydrated Bloc

  // be able to call native code
  WidgetsFlutterBinding.ensureInitialized();

  //native code
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  //All data will be saved in JSON format

  runApp(
    MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    ),
  );
}

// BlocProvider closes provided bloc/cubit automatically
// BlocProvider.value - we have to manually close the provided bloc/cubit
// we can only dispose it inside a StateFul widget!!

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter, required this.connectivity});

  //final CounterCubit _counterCubit = CounterCubit();
  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(create: (context) {
          final counterCubit = CounterCubit();
          counterCubit.hydrate(); // applies hydrate() to a existing CounterCubit instance
          return counterCubit;
        }),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // passing function as pointer/argument
        // we are NOT passing the return value of function!!!
        onGenerateRoute: appRouter.onGenerateRoute,
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
