import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class CounterCubit extends Cubit<int> {
  int inisialData;

  CounterCubit({
    this.inisialData = 0,
  }) : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  // Bloc Observerable
  // Observable<int> get stream => super.stream;
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    debugPrint('$change');
  }

  // Error handling
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint('$error, $stackTrace');
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final counterCubit = CounterCubit(inisialData: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUBIT APPS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              initialData: counterCubit.inisialData,
              stream: counterCubit.stream,
              builder: (context, snapshot) {
                /// Usefull if want handle without initialData
                /// functionality to show loading indicator
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const CircularProgressIndicator();
                // } else {
                //   return Text(
                //     '${snapshot.data}',
                //     style: const TextStyle(fontSize: 40),
                //   );
                // }

                ///functionality to show data if has initialData
                return Text(
                  '${snapshot.data}',
                  style: const TextStyle(fontSize: 40),
                );
              },
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => counterCubit.decrement(),
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () => counterCubit.increment(),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
