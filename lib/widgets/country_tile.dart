import 'package:countriescode/modal.dart/country.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  final Country? country;

  CountryTile({Key? key, @required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 50,
      child: Row(children: [
        const SizedBox(
          width: 10,
        ),
        Text(country!.emoji, style: TextStyle(fontSize: 24)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            country!.name,
            maxLines: 1,
          ),
        )
      ]),
    ));
  }
}
