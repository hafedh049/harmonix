import 'package:flutter/material.dart';
import 'package:harmonix/models/user_model.dart';
import 'package:hive/hive.dart';

const Color transparent = Colors.transparent;
const Color gray = Color.fromARGB(255, 51, 56, 66);
const Color white = Colors.white;
const Color yellow = Colors.yellow;
const Color blue = Colors.blueAccent;
const Color teal = Colors.teal;

Box? userLocalSettings;

UserModel? user;

final List<String> climateChangeQuotes = <String>[
  "Climate change is no longer some far-off problem; it is happening here, it is happening now.",
  "The greatest threat to our planet is the belief that someone else will save it.",
  "We do not inherit the earth from our ancestors; we borrow it from our children.",
  "Climate change is happening, humans are causing it, and I think this is perhaps the most serious environmental issue facing us.",
  "The Earth does not belong to us: we belong to the Earth.",
  "Climate change is the single biggest thing that humans have ever done on this planet. The one thing that needs to be bigger is our movement to stop it.",
  "The science is clear. The future is not.",
  "We are running the most dangerous experiment in history right now, which is to see how much carbon dioxide the atmosphere can handle before there is an environmental catastrophe.",
  "We are the first generation to feel the effect of climate change and the last generation who can do something about it.",
  "Climate change is a terrible problem, and it absolutely needs to be solved. It deserves to be a huge priority.",
];
