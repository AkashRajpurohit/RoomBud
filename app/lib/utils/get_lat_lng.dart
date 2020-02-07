import 'dart:math';

class LatLng {

  Map<String, double> getLatLng() {

    Map coords = Map<String, double>();

    coords['lat'] = 19.4625793;
    coords['long'] = 72.7699177;

    final rnd = new Random();
    double min = 0.0000005;

    double r = min * rnd.nextDouble();

    coords['lat'] += r;
    coords['long'] += r;

    coords['lat'] = double.parse(coords['lat'].toStringAsFixed(7));
    coords['long'] = double.parse(coords['long'].toStringAsFixed(7));

    return coords;

  }

}