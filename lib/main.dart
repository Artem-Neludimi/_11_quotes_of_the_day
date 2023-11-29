import 'dart:io';

import 'package:_11_quotes_of_the_day/db/database.dart';
import 'package:_11_quotes_of_the_day/quotes_cubit.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'home.dart';

late SharedPreferences prefs;
late AppDatabase db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = AppDatabase(_openConnection());
  // await db.quoteDao.insertQuote(
  //   const Quote(
  //     id: '',
  //     content: 'Hello World',
  //     author: 'Flutter',
  //     authorSlug: 'flutter',
  //     length: 11,
  //   ),
  // );
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastDark(),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => QuotesCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}
