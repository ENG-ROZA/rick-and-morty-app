import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/data/webservices/character_webservices.dart';

class CharactersRepository {
  final CharacterWebservices characterWebservices; //calling web services
  CharactersRepository(this.characterWebservices);
  Future<List<CharactersModel>> getAllCharacters() async {
    final mapOFCharcters = await characterWebservices.getAllCharacters(); //access getAllCharacters function from web services
    final List<dynamic> charcters = mapOFCharcters["results"]; 
    return charcters
        .map((characters) => CharactersModel.fromJson(characters))
        .toList();
  }
}
