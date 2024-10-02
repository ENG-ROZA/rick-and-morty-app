import 'package:bloc/bloc.dart';
import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
   List<CharactersModel> characters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharactersModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters = characters ;
    });
    return characters ;
  }
}
