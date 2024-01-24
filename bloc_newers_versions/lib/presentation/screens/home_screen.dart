import 'package:bloc_newer_versions/constants/enums.dart';
import 'package:bloc_newer_versions/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.title, this.color});

  final String? title;
  final Color? color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text("Wifi");
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text("Mobile");
                } else if (state is InternetDisconnected) {
                  return const Text("Disconnected");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
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
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    "Counter: ${counterState.counter} Internet: Mobile",
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    "Counter: ${counterState.counter} Internet: Wifi",
                  );
                } else {
                  return Text(
                    "Counter: ${counterState.counter} Internet: Disconnected",
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            // context.select() is replacement for buildWhen property
            // however for more complex scenario it is recommended to use buildWhen inside BlocBuilder
            // context.select checks if current state differs from previous one
            // if yes then only then rebuilds the UI
            Builder(
              builder: (context) {
                final counterValue =
                    context.select((CounterCubit cubit) => cubit.state.counter);
                return Text("Counter : $counterValue");
              },
            ),
            const SizedBox(height: 24),
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
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
              ),
              onPressed: () {
                /*Navigator.of(context).push(
                    MaterialPageRoute(
                      // (_) because it can not be named context
                      // we want to refer to the context of Navigator.of(context)
                      // and not a brand new context
                      builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<CounterCubit>(context),
                          child: const SecondScreen(
                            title: "Second Screen",
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  );*/
                Navigator.of(context).pushNamed("/second");
              },
              child: const Text("Go to second screen"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/third");
              },
              child: const Text("Go to Third screen"),
            ),
          ],
        ),
      ),
    );
  }
}
