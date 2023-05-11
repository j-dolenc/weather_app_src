import 'package:flutter/material.dart';

class City extends StatelessWidget {
  const City({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 46),
      child: Text(
        city,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white70,
              fontSize: 60,
            ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
