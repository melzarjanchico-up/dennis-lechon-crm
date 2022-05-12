//import 'dart:io';

import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final Customer customer;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.customer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
              onTap: () async {},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: buildEditIcon(color)
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          fit: BoxFit.fill,
          image: image,
          width: 250,
          height: 280,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
