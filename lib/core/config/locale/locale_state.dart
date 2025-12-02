import 'package:equatable/equatable.dart';

/// Locale state for managing app language
class LocaleState extends Equatable {
  final String languageCode;

  const LocaleState({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];

  LocaleState copyWith({String? languageCode}) {
    return LocaleState(
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
