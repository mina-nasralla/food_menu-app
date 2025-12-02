import 'package:flutter_bloc/flutter_bloc.dart';
import 'locale_state.dart';

/// Cubit for managing app locale/language
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(languageCode: 'en'));

  /// Toggle between English and Arabic
  void toggleLanguage() {
    final newLanguage = state.languageCode == 'en' ? 'ar' : 'en';
    emit(state.copyWith(languageCode: newLanguage));
  }

  /// Set specific language
  void setLanguage(String languageCode) {
    emit(state.copyWith(languageCode: languageCode));
  }
}
