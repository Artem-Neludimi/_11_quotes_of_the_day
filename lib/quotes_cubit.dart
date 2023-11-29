import 'package:_11_quotes_of_the_day/models/qoute_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(const QuotesState());

  final TextEditingController searchController = TextEditingController();

  Future<void> init() async {
    final response = await Dio().get('https://api.quotable.io/random');
    final randomQuote = QuoteModel.fromJson(response.data);
    emit(QuotesState(quoteOfTheDay: randomQuote, loading: false));

    searchController.addListener(() {
      if (searchController.text.trim().isEmpty) {
        emit(state.copyWith(searchResults: [], dataFound: true));
      } else {
        searchQuote();
      }
    });
  }

  Future<void> searchQuote() async {
    try {
      final response = await Dio().get('https://api.quotable.io/search/quotes', queryParameters: {
        'query': searchController.text,
      });
      final resultsQuotes = (response.data['results'] as List).map((e) => QuoteModel.fromJson(e)).toList();
      emit(state.copyWith(searchResults: resultsQuotes, dataFound: resultsQuotes.isNotEmpty));
    } catch (e) {
      emit(state.copyWith(searchResults: [], dataFound: false));
    }
  }
}

class QuotesState {
  const QuotesState({
    this.loading = true,
    this.quoteOfTheDay,
    this.searchResults = const [],
    this.dataFound = true,
  });

  final bool loading;
  final QuoteModel? quoteOfTheDay;
  final List<QuoteModel> searchResults;
  final bool dataFound;

  QuotesState copyWith({
    bool? loading,
    QuoteModel? quoteOfTheDay,
    List<QuoteModel>? searchResults,
    bool? dataFound,
  }) {
    return QuotesState(
      loading: loading ?? this.loading,
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
      searchResults: searchResults ?? this.searchResults,
      dataFound: dataFound ?? this.dataFound,
    );
  }
}
