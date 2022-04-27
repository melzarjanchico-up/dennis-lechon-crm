import 'package:flutter/material.dart';
//import 'dart:convert';

class Tag {
  final String name;
  final Color tagColor;
  final int index;
  //final String? addedBy;

  const Tag({
    required this.name,
    required this.tagColor,
    required this.index,
    //this.addedBy
  });

  /*
  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        tagColor: json["tagColor"],
        index: json["index"],
        //addedBy: json["addedBy"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tagColor": tagColor,
        "index": index,
        //""
      };
  */
}
