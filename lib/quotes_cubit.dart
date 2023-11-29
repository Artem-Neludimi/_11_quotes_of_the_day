import 'package:_11_quotes_of_the_day/models/qoute_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(const QuotesState());

  Future<void> init() async {
    final response = await Dio().get('https://api.quotable.io/random');
    final randomQuote = QuoteModel.fromJson(response.data);
    emit(QuotesState(quoteOfTheDay: randomQuote, loading: false));
  }

  Future<void> searchQuote(String query) async {
    try {
      final response = await Dio().get('https://api.quotable.io/search/quotes', queryParameters: {
        'query': query,
      });
      emit(state.copyWith(
          searchResults: (response.data['results'] as List).map((e) => QuoteModel.fromJson(e)).toList()));
    } catch (e) {
      emit(state.copyWith(searchResults: []));
    }
  }
}

class QuotesState {
  const QuotesState({
    this.loading = true,
    this.quoteOfTheDay,
    this.searchResults  = const [],
  });

  final bool loading;
  final QuoteModel? quoteOfTheDay;
  final List<QuoteModel> searchResults;

  QuotesState copyWith({
    bool? loading,
    QuoteModel? quoteOfTheDay,
    List<QuoteModel>? searchResults,
  }) {
    return QuotesState(
      loading: loading ?? this.loading,
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
