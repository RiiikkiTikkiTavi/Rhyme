// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhyme/bloc/theme/theme_cubit.dart';
import 'package:rhyme/features/history/history.dart';
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
              onTap: () => _confirmClearHistory(context),
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

  void _confirmClearHistory(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(onConfirm: () {_clearHistory(context);},),
      );
      return;
    }
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConfirmationDialog(onConfirm: () {_clearHistory(context);},) 
    );

    //BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }

  void _clearHistory(BuildContext context) => BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key,
  required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
    return AlertDialog(
      content: const _DialogContent(crossAxisAlignment: CrossAxisAlignment.start,),
      backgroundColor: theme.cardColor,
      surfaceTintColor: theme.cardColor,
      actions: [
        TextButton(
          onPressed: () {
            _confirm(context);
          },
          child: Text('Да', style: TextStyle(color: theme.hintColor)),
        ),
        TextButton(
          onPressed: () => _close(context),
          child: const Text('Нет'),
        ),
      ],
    );
  }
  return CupertinoAlertDialog(
        content: const _DialogContent(crossAxisAlignment: CrossAxisAlignment.center,),
        actions: [
          CupertinoDialogAction(
            onPressed: () =>_confirm(context),
            isDestructiveAction: true,
            child: Text(
              'Да',
              style: TextStyle(color: theme.cupertinoAlertColor),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => _close(context),
            isDefaultAction: true,
            child: const Text(
              'Нет',
              style: TextStyle(color: Color(0xFF3478F7)),
            ),
          ),
        ],
      );
  }

  void _close(BuildContext context){
   Navigator.of(context).pop(); 
  }

  void _confirm(BuildContext context){
    onConfirm.call();
    Navigator.of(context).pop(); 
  }


}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.crossAxisAlignment,
  });

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text('Вы уверны?', style: theme.textTheme.headlineSmall),
        Text(
          'Данные будут удалены навсегда',
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
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
