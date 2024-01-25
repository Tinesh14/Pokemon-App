import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poke_app/modules/home/ui/home_ui.dart';
import 'package:poke_app/modules/network/services_network.dart';

import 'config/routes/routes.dart';
import 'config/themes/style.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await getHydratedStorage();
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MultiProvider(
        providers: [
          Provider<Network>(
            create: (context) => Network(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
    storage: storage,
    blocObserver: MyBlocObserver(),
  );
}

Future<HydratedStorage?> getHydratedStorage() async {
  HydratedStorage? result;
  var temporaryDirectory;
  try {
    temporaryDirectory = await getApplicationDocumentsDirectory();
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    if (temporaryDirectory != null) {
      result = await HydratedStorage.build(
        storageDirectory: temporaryDirectory,
      );
    }
  } catch (e) {
    debugPrint("HydratedStorage Exception:\n${e.toString()}");
  }
  return result;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: true,
      theme: appTheme,
      routes: PageRoutes().routes(),
      home: const HomeUi(),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}
