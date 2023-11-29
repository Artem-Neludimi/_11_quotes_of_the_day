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
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16).copyWith(top: 32),
        child: state.loading
            ? const CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Text(
                    'Quote of the day',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(state.quoteOfTheDay!.content, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(state.quoteOfTheDay!.author, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 16),
                  TextField(
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    onChanged: (value) => context.read<QuotesCubit>().searchQuote(value),
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.searchResults.length,
                      itemBuilder: (context, index) {
                        final quote = state.searchResults[index];
                        return ListTile(
                          title: Text(quote.content),
                          subtitle: Text(quote.author),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
