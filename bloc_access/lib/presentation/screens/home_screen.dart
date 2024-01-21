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
