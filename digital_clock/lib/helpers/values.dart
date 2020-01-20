import 'package:flutter/material.dart';

enum Element {
  emptySpace,
  background,
  text,
  shadow,
  fill,
}

//List containing references to the various themes
final lightThemes = [
  _lightCloudy,
  _lightFoggy,
  _lightRainy,
  _lightSnowy,
  _lightSunny,
  _lightThunderstorm,
  _lightWindy,
];

final darkThemes = [
  _darkCloudy,
  _darkFoggy,
  _darkRainy,
  _darkSnowy,
  _darkSunny,
  _darkThunderstorm,
  _darkWindy,
];

//Color values for each theme
final _lightCloudy = {
  Element.emptySpace: Colors.blue.withOpacity(0.25),
  Element.background: Colors.white.withOpacity(0.3),
  Element.text: Colors.tealAccent,
  Element.shadow: Colors.teal.withOpacity(0.25),
  Element.fill: Colors.white,
};

final _lightFoggy = {
  Element.emptySpace: Colors.black26.withOpacity(0.2),
  Element.background: Colors.grey.withOpacity(0.3),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.4),
  Element.fill: Colors.redAccent,
};

final _lightRainy = {
  Element.emptySpace: Colors.teal.withOpacity(0.2),
  Element.background: Colors.teal.withOpacity(0.6),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.4),
  Element.fill: Colors.limeAccent,
};

final _lightSnowy = {
  Element.emptySpace: Colors.black.withOpacity(0.2),
  Element.background: Colors.white.withOpacity(0.4),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.5),
  Element.fill: Colors.black87,
};

final _lightSunny = {
  Element.emptySpace: Colors.deepOrange.withOpacity(0.2),
  Element.background: Colors.orange.withOpacity(0.3),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.3),
  Element.fill: Colors.yellow,
};

final _lightThunderstorm = {
  Element.emptySpace: Colors.pink.withOpacity(0.2),
  Element.background: Colors.pinkAccent.withOpacity(0.4),
  Element.text: Colors.white,
  Element.shadow: Colors.deepPurple.withOpacity(0.5),
  Element.fill: Colors.pinkAccent,
};
final _lightWindy = {
  Element.emptySpace: Colors.greenAccent.withOpacity(0.3),
  Element.background: Colors.lightBlueAccent.withOpacity(0.4),
  Element.text: Colors.greenAccent,
  Element.shadow: Colors.black.withOpacity(0.2),
  Element.fill: Colors.white,
};

final _darkCloudy = {
  Element.emptySpace: Colors.blue.withOpacity(0.05),
  Element.background: Colors.white.withOpacity(0.1),
  Element.text: Colors.tealAccent,
  Element.shadow: Colors.black.withOpacity(0.25),
  Element.fill: Colors.white,
};

final _darkFoggy = {
  Element.emptySpace: Colors.black26.withOpacity(0.2),
  Element.background: Colors.grey.withOpacity(0.2),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.4),
  Element.fill: Colors.redAccent,
};

final _darkRainy = {
  Element.emptySpace: Colors.teal.withOpacity(0.2),
  Element.background: Colors.teal.withOpacity(0.15),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.4),
  Element.fill: Colors.limeAccent,
};

final _darkSnowy = {
  Element.emptySpace: Colors.black.withOpacity(0.2),
  Element.background: Colors.white.withOpacity(0.4),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.5),
  Element.fill: Colors.black87,
};

final _darkSunny = {
  Element.emptySpace: Colors.deepOrange.withOpacity(0.2),
  Element.background: Colors.orange.withOpacity(0.25),
  Element.text: Colors.white,
  Element.shadow: Colors.black.withOpacity(0.3),
  Element.fill: Colors.yellow,
};

final _darkThunderstorm = {
  Element.emptySpace: Colors.pink.withOpacity(0.1),
  Element.background: Colors.pinkAccent.withOpacity(0.225),
  Element.text: Colors.white,
  Element.shadow: Colors.deepPurple.withOpacity(0.5),
  Element.fill: Colors.pinkAccent,
};

final _darkWindy = {
  Element.emptySpace: Colors.lightBlue.withOpacity(0.05),
  Element.background: Colors.lightBlueAccent.withOpacity(0.2),
  Element.text: Colors.greenAccent,
  Element.shadow: Colors.black.withOpacity(0.25),
  Element.fill: Colors.white,
};

//The custom images that are being used to display the digits of the clock
List<ImageProvider> numImages = [
  AssetImage("assets/graphics/num_0.png"),
  AssetImage("assets/graphics/num_1.png"),
  AssetImage("assets/graphics/num_2.png"),
  AssetImage("assets/graphics/num_3.png"),
  AssetImage("assets/graphics/num_4.png"),
  AssetImage("assets/graphics/num_5.png"),
  AssetImage("assets/graphics/num_6.png"),
  AssetImage("assets/graphics/num_7.png"),
  AssetImage("assets/graphics/num_8.png"),
  AssetImage("assets/graphics/num_9.png"),
];
