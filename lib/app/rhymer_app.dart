// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/app/app.dart';
import 'package:rhyme/bloc/theme/theme_cubit.dart';
import 'package:rhyme/router/router.dart';
import 'package:rhyme/ui/theme/theme.dart';

class RhymeApp extends StatefulWidget {
  const RhymeApp({super.key, required this.config});

  final AppConfig config;

  @override
  State<RhymeApp> createState() => _RhymeAppState();
}

class _RhymeAppState extends State<RhymeApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      config: widget.config,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rhyme',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
