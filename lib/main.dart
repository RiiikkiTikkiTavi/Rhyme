import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromARGB(255, 253, 44, 17);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: Colors.white70,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // закрепить appbar наверху
            //snap: true, // только при floating: true, зафиксировать в поле зрения
            floating: true, // сделать видимой при прокручивании вверх
            title: Text("Rhyme"),
            //backgroundColor: theme.primaryColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: SearchButton(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ), // передать другой виджет в сливер
          SliverList.builder(itemBuilder: (context, index) => RhymeListCard()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {},
      ),
    );
  }
}

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Рифма', style: theme.textTheme.bodyLarge),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: theme.hintColor.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      decoration: BoxDecoration(
        //color: theme.hintColor.withValues(alpha: 10),
        color: theme.hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded),
          SizedBox(width: 12),
          Text(
            "поиск рифм...",
            style: TextStyle(
              fontSize: 18,
              color: theme.hintColor.withValues(alpha: 0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
