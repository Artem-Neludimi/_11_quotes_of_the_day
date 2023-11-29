import 'package:_11_quotes_of_the_day/models/qoute_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(const QuotesState());

  Future<void> init() async {
    final response = await dio.get('https://api.quotable.io/random');
    final randomQuote = QuoteModel.fromJson(response.data);
    emit(QuotesState(quoteOfTheDay: randomQuote, loading: false));
  }
}

class QuotesState {
  const QuotesState({
    this.loading = true,
    this.quoteOfTheDay,
  });

  final bool loading;
  final QuoteModel? quoteOfTheDay;

  QuotesState copyWith({
    bool? loading,
    QuoteModel? quoteOfTheDay,
  }) {
    return QuotesState(
      loading: loading ?? this.loading,
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
    );
  }
}
