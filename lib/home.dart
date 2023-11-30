import 'package:_11_quotes_of_the_day/main.dart';
import 'package:_11_quotes_of_the_day/saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'quotes_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<QuotesCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuotesCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Quotes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedPage())),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<QuotesCubit>().refresh(),
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16).copyWith(top: 8),
        child: state.loading
            ? const CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  ListTile(
                    title: Text(state.quoteOfTheDay!.content),
                    subtitle: Text(state.quoteOfTheDay!.author),
                    trailing: IconButton(
                      onPressed: () => db.quoteDao.insertQuote(state.quoteOfTheDay!.toDataClass()),
                      icon: const Icon(Icons.save),
                    ),
                    
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: context.read<QuotesCubit>().searchController,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: const InputDecoration(
                      hintText: 'Enter search query',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: switch (state.dataFound) {
                      false => const Center(child: Text('No data found')),
                      true => ListView.builder(
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            final quote = state.searchResults[index];
                            return ListTile(
                              title: Text(quote.content),
                              subtitle: Text(quote.author),
                              trailing: IconButton(
                                onPressed: () => db.quoteDao.insertQuote(state.quoteOfTheDay!.toDataClass()),
                                icon: const Icon(Icons.save),
                              ),
                            );
                          },
                        ),
                    },
                  )
                ],
              ),
      ),
    );
  }
}
