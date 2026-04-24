import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'data/repositories/user_repository_impl.dart';
import 'helper/database_helper.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            UserRepositoryImpl(DatabaseHelper()),
          )..add(LoadUsers()), // Langsung muat data saat aplikasi dibuka
        ),
      ],
      child: MaterialApp(
        title: 'Flutter SQLite BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}