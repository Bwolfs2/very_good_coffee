import 'package:core/core.dart';
import 'package:drift_local_data_impl/drift_local_data_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:local_data_abstractions/local_data_abstractions.dart';
import 'package:very_good_coffee/src/domain/repoistories/coffee_local_data_repository.dart';
import 'package:very_good_coffee/src/view/list_images/list_images_page.dart';
import 'package:very_good_coffee/src/view/splash/splash_page.dart';

import 'src/data/repositories/coffee_local_data_repository_impl.dart';
import 'src/data/repositories/coffee_repository_impl.dart';
import 'src/domain/model/coffee_image.dart';
import 'src/domain/repoistories/coffee_api_repository.dart';
import 'src/view/home/home_page.dart';
import 'src/view/image_details/image_details_page.dart';
import 'src/view/new_coffee_image/new_coffee_image_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeLocalDataSource>(
          create: (context) => CoffeeDataSourceDriftImpl(),
        ),
        RepositoryProvider<IHttpClient>(
          create: (context) => HttpClientImpl(),
        ),
        RepositoryProvider<CoffeeApiRepository>(
          create: (context) => CoffeeApiRepositoryImpl(
            httpClient: context.read<IHttpClient>(),
          ),
        ),
        RepositoryProvider<CoffeeLocalDataRepository>(
          create: (context) => CoffeeLocalDataRepositoryImpl(
            context.read<CoffeeLocalDataSource>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Very Good Coffee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/new_coffee_image': (context) => const NewCoffeeImagePage(),
          '/list_images': (context) => ListImagesPage(),
          '/image_details': (context) => ImageDetailsPage(
                image:
                    ModalRoute.of(context)!.settings.arguments as CoffeeImage,
              ),
        },
      ),
    );
  }
}
