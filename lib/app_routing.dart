import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/data/repository/characters_repository.dart';
import 'package:flutter_breakingbad/data/webservices/character_webservices.dart';
import 'package:flutter_breakingbad/presentation/screens/charcters_details_screen.dart';
import 'package:flutter_breakingbad/presentation/screens/charcters_screen.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/strings.dart';


class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(
        CharacterWebservices()); //which depends on CharacterWebservices. This class is likely responsible for making HTTP requests to an API to retrieve character data.

    charactersCubit = CharactersCubit(
        charactersRepository); // dependancy injection applying in this line via passing charactersRepository to charactersCubit through constructor.
    //A CharactersCubit is created using the charactersRepository. This cubit will manage the state of the character data in the app.
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charctersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext contxt) =>
                      charactersCubit, // a BlocProvider is used to provide the CharactersCubit to the CharctersScreen.
                  child: const CharctersScreen(),
                ));

      case charactersDetailsScreen:
        final selectedCharacter = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) =>
                CharctersDetailsScreen(charactersModel: selectedCharacter));
    }
    return null;
  }
}

/* 
 Concepts Explained

Routing:


The AppRouter class is responsible for routing within the application. It determines which screen to show based on the route name and provides any necessary data to that screen.
Dependency Injection:

The AppRouter class demonstrates dependency injection by passing the CharactersRepository to the CharactersCubit through the constructor. This makes the code more modular and testable.
Bloc Pattern:

The use of BlocProvider to provide the CharactersCubit to screens is a core part of the Bloc pattern, which separates business logic from UI components.
State Management:

The CharactersCubit is used for state management in this application. It fetches character data and manages the different states (loading, loaded, etc.) that the UI can react to.
Navigation and Argument Passing:

The code also shows how to pass arguments between screens in Flutter. The selectedCharacter is passed from the characters screen to the details screen, allowing the details screen to display information about the selected character.


*/