import 'package:flutter/material.dart';

class Word {
  final String content;
  final List<Image> images;

  Word(this.content, {this.images = const []});
}
