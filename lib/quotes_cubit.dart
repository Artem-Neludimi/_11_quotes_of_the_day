import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(QuotesState());

  Future<void> init() async {
    final a = await dio.get('https://api.quotable.io/random');
    emit(QuotesState(a: a));
  }
}

class QuotesState {
  QuotesState({this.a});

  final dynamic a;
}
