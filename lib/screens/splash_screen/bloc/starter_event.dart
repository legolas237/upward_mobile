part of 'starter_bloc.dart';

@immutable
sealed class StarterEvent {}

@immutable
class InitAuth extends StarterEvent {}
