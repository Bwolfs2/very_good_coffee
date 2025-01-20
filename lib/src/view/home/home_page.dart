import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/coffee_image.dart';
import 'bloc/background_cubit.dart';
import 'bloc/favorite_count_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteCountCubit(
            context.read(),
          )..getFavoriteCount(),
        ),
        BlocProvider(
          create: (context) => BackgroundCubit(
            context.read(),
          )..loadBackground(),
        ),
      ],
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<FavoriteCountCubit, int?>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/list_images');
                  if (context.mounted) {
                    context.read<BackgroundCubit>().loadBackground();
                    context.read<FavoriteCountCubit>().getFavoriteCount();
                  }
                },
                icon: state != null
                    ? Badge.count(
                        count: state,
                        child: const Icon(Icons.menu, color: Colors.white),
                      )
                    : const Icon(Icons.menu, color: Colors.white),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body:
          BlocBuilder<BackgroundCubit, CoffeeImage?>(builder: (context, state) {
        if (state == null) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: MemoryImage(state.fileEncoded),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: .6),
                BlendMode.srcOver,
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/new_coffee_image');
          if (context.mounted) {
            context.read<FavoriteCountCubit>().getFavoriteCount();
          }
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
