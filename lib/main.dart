import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:very_good_coffee/core/http_client.dart';

import 'src/data/repositories/coffee_repository_impl.dart';
import 'src/domain/model/coffee_image.dart';
import 'src/domain/repoistories/coffee_api_repository.dart';
import 'src/view/home/home_page.dart';
import 'src/view/image_details/image_details_page.dart';
import 'src/view/list_images/list_images_page.dart';
import 'src/view/new_coffee_image/new_coffee_image_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IHttpClient>(
          create: (context) => HttpClientImpl(httpClient: Client()),
        ),
        RepositoryProvider<CoffeeApiRepository>(
          create: (context) => CoffeeApiRepositoryImpl(
            httpClient: context.read<IHttpClient>(),
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
          '/': (context) => const HomePage(),
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
