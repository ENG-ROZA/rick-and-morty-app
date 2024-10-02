import 'package:flutter/material.dart';
import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/colors.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/strings.dart';

class ChractersItem extends StatelessWidget {
  const ChractersItem({super.key, required this.charactersModel});
  final CharactersModel charactersModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, charactersDetailsScreen,
              arguments: charactersModel);
        },
        child: GridTile(
          footer: Hero(
            tag: charactersModel.id!.toInt(), // To understand
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.bottomCenter,
              color: Colors.black54,
              child: Text(
                (charactersModel.name ?? ""),
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.3,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.myGrey,
            child: charactersModel.image.toString().isEmpty
                ? Image.asset(
                    "assets/images/error.jpg",
                  )
                : FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: "assets/images/loading.gif",
                    image: charactersModel.image.toString(),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
