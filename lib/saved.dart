import 'package:_11_quotes_of_the_day/main.dart';
import 'package:_11_quotes_of_the_day/models/quote_model.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.quoteDao.watchQuotes(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved'),
            ),
            body: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final quote = QuoteModel.fromDataClass(snapshot.data![index]);
                return ListTile(
                  title: Text(quote.content),
                  subtitle: Text(quote.author),
                  trailing: IconButton(
                    onPressed: () => db.quoteDao.deleteQuote(snapshot.data![index]),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          );
        });
  }
}
