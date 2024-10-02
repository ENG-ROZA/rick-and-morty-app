import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/presentation/screens/search.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/colors.dart';
import 'package:flutter_breakingbad/presentation/utils/widgets/characters_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharctersScreen extends StatefulWidget {
  const CharctersScreen({super.key});

  @override
  State<CharctersScreen> createState() => _CharctersScreenState();
}

class _CharctersScreenState extends State<CharctersScreen> {
  late List<CharactersModel> allCharacters;
  
  bool  wasOffline = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters(); //calling cubit to Ui
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters; //equal list allCharacters with List characters in the CharactersLoaded class.
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: allCharacters.length,
        itemBuilder: (ctx, index) {
          return ChractersItem(
            charactersModel: allCharacters[index],
          );
        });
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "NO INTERNET",
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset(
              "assets/images/undraw_Internet_on_the_go_re_vben.png",
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.myYellow,
        title: const Text(
          "Rick And Morty",
          style: TextStyle(color: MyColors.myGrey),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (allCharacters.isNotEmpty) {
                showSearch(
                  context: context,
                  delegate: Search(allCharacters),
                );
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);

            // Check if the state changed from offline to online
          if (connected && wasOffline) {
            // Trigger data fetching when connection is restored
            BlocProvider.of<CharactersCubit>(context).getAllCharacters();
          }

          // Update the offline state
          wasOffline = !connected;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: const Center(
            child: CircularProgressIndicator(
          color: MyColors.myYellow,
        )),
      ),
    );
  }
}