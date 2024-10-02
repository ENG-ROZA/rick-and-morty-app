// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/colors.dart';

class CharctersDetailsScreen extends StatelessWidget {
  const CharctersDetailsScreen({super.key, required this.charactersModel});
  final CharactersModel charactersModel;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          charactersModel.name ?? "",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        background: Hero(
            tag: charactersModel.id!.toInt(),
            child: Image.network(
              charactersModel.image.toString(),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: value,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ]));
  }

  Widget buildDivider(double endIdent) {
    return Divider(
      endIndent: endIdent,
      thickness: 2,
      color: MyColors.myYellow,
      height: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo(
                    "Gender : ",
                    charactersModel.gender.toString(),
                  ),
                  buildDivider(310),
                  characterInfo(
                    "Status : ",
                    charactersModel.statuesIfDeadOrLife.toString(),
                  ),
                  buildDivider(315),
                  characterInfo(
                    "Species : ",
                    charactersModel.species.toString(),
                  ),
                  buildDivider(301),
                  characterInfo(
                    "Origin : ",
                    charactersModel.origin.toString(),
                  ),
                  buildDivider(319),
                  characterInfo(
                    "Location : ",
                    charactersModel.location.toString(),
                  ),
                  buildDivider(296),
                  characterInfo(
                    "Created At : ",
                    charactersModel.created!.substring(0, 10),
                  ),
                  buildDivider(280),
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }
}
