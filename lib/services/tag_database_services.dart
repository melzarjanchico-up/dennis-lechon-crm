import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/tags.dart';
import 'package:flutter/material.dart';

class TagService {
  final CollectionReference tagCollection = FirebaseFirestore.instance.collection('tags');

  List<Tag> _tagListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        String preTagName = (doc.data() as Map)['name'] ?? '';
        String preTagColor = (doc.data() as Map)['color'] ?? '';
        int preTagIndex = (doc.data() as Map)['index'] ?? '';
        //String? preAddedBy = (doc.data() as Map)['added_by'];

        return Tag(
          tagColor: Color(int.parse((preTagColor).split('(0x')[1].split(')')[0], radix: 16)),
          name: preTagName,
          index: preTagIndex,
          //addedBy: preAddedBy
        );
      }
    ).toList();
  }

  Stream<List<Tag>>? get tags {
    return tagCollection
        .orderBy('index')
        .snapshots()
        .map(_tagListFromSnapshot);
  }

  Stream<List<Tag>> makeStream(List<Tag> list) async* {
    yield list;
  }
}