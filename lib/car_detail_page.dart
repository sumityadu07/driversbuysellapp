import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BuyCarPage.dart';

class CarDetailPage extends StatelessWidget {
  final CarModel car;
  final List<CarModel> allCars;

  const CarDetailPage({required this.car, required this.allCars, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(car.image, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(car.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(car.price, style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 10),
            Text('KM Driven: ${car.kmDriven}'),
            Text('Fuel Type: ${car.fuelType}'),
            Text('Transmission: ${car.transmission}'),
            Text('Owner: ${car.owner}'),
            Text('EMI: ${car.emi}'),
            Text('Location: ${car.location}'),
          ],
        ),
      ),
    );
  }
}
