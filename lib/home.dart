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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<QuotesCubit>().refresh(),
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16).copyWith(top: 32),
        child: state.loading
            ? const CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Text(
                    'Best quote',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(state.quoteOfTheDay!.content, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(state.quoteOfTheDay!.author, style: Theme.of(context).textTheme.bodySmall),
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
