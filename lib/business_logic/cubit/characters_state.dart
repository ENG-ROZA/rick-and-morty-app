// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
 late final List<CharactersModel> characters;
  CharactersLoaded(
     this.characters,
  );
 
}
