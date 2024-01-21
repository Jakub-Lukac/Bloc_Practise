
// ignore_for_file: unused_field, unused_element

import 'package:bloc_access/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented!) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Incremented!"),
                      duration: Duration(
                        milliseconds: 300,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Decrement!"),
                      duration: Duration(
                        milliseconds: 300,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counter! < 0) {
                  return Text(
                    "BRR NEGATIVE ${state.counter.toString()}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counter! % 2 == 0) {
                  return Text(
                    "YAAAY ${state.counter.toString()}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counter! == 5) {
                  return Text(
                    "HMM, NUMBER ${state.counter.toString()}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    state.counter.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => context.read<CounterCubit>().decrement(),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<CounterCubit>().increment(),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
