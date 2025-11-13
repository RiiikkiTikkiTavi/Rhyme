import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/bloc/theme/theme_cubit.dart';
import 'package:rhyme/features/settings/settings.dart';
import 'package:rhyme/ui/theme/theme.dart';
import 'package:rhyme/ui/widgets/base_container.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Настройки'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: SettingsCard(
              title: 'Темная тема',
              value: isDarkTheme,
              onChanged: (value) => _setThemeBrightness(context, value),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: SettingsCard(
              title: 'Уведомления',
              value: true,
              onChanged: (value) {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: SettingsCard(
              title: 'Разрешить аналитику',
              value: true,
              onChanged: (value) {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Очистить историю',
              iconData: Icons.delete_sweep_outlined,
              iconColor: theme.primaryColor,
              onTap: () => _clearHistory(context),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Поддержка',
              iconData: Icons.message_outlined,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _setThemeBrightness(BuildContext context, bool value) {
    context.read<ThemeCubit>().setThemeBrightness(
      value ? Brightness.dark : Brightness.light,
    );
  }

  void _clearHistory(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => const ConfirmationDialog(),
      );
      return;
    }
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Вы уверны?', style: theme.textTheme.headlineSmall),
            Text(
              'Данные будут удалены навсегда',
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            isDestructiveAction: true,
            child: Text(
              'Да',
              style: TextStyle(color: theme.cupertinoAlertColor),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            isDefaultAction: true,
            child: const Text(
              'Нет',
              style: TextStyle(color: Color(0xFF3478F7)),
            ),
          ),
        ],
      ),
    );

    //BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Вы уверны?', style: theme.textTheme.headlineSmall),
          Text(
            'Данные будут удалены навсегда',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
      backgroundColor: theme.cardColor,
      surfaceTintColor: theme.cardColor,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Да', style: TextStyle(color: theme.hintColor)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Нет'),
        ),
      ],
    );
  }
}

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    super.key,
    required this.title,
    required this.iconData,
    this.onTap,
    this.iconColor,
  });

  final String title;
  final IconData iconData;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BaseContainer(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
              ),
              Icon(
                iconData,
                size: 32,
                color: iconColor ?? theme.hintColor.withAlpha(70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
