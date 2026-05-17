import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/datasources/local_hive_data_source.dart';
import 'data/repositories/question_repository_impl.dart';
import 'core/utils/data_seeder.dart';
import 'presentation/providers/repository_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final dataSource = await LocalHiveDataSource.init();

  final qRepo = QuestionRepositoryImpl(dataSource);
  final questions = await qRepo.getQuestions();
  if (questions.isEmpty) {
    await qRepo.seedQuestions(DataSeeder.generateMockQuestions(1000));
  }

  runApp(
    ProviderScope(
      overrides: [dataSourceProvider.overrideWithValue(dataSource)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DSA Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
