import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/background/background_cubit.dart';
import 'cubits/background/background_states.dart';
import 'cubits/favorite_count/favorite_count_cubit.dart';
import 'cubits/favorite_count/favorite_count_states.dart';

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
          BlocConsumer<FavoriteCountCubit, FavoriteCountStates>(
            listener: (context, state) {
              if (state is FavoriteCountError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red[100],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is FavoriteCountLoaded) {
                return IconButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/list_images');
                    if (context.mounted) {
                      context.read<BackgroundCubit>().loadBackground();
                      context.read<FavoriteCountCubit>().getFavoriteCount();
                    }
                  },
                  icon: Badge.count(
                    count: state.count,
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<BackgroundCubit, BackgroundStates>(
          builder: (context, state) {
        return switch (state) {
          BackgroundInitial() || BackgroundError() => const SizedBox.shrink(),
          BackgroundLoaded() => Container(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: MemoryImage(state.image.fileEncoded),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: .6),
                    BlendMode.srcOver,
                  ),
                ),
              ),
            ),
        };
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
