import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'car_detail_page.dart';

class CarModel {
  final String title;
  final String brand;
  final String image;
  final String price;
  final String kmDriven;
  final String fuelType;
  final String transmission;
  final String owner;
  final String emi;
  final String location;

  CarModel({
    required this.title,
    required this.brand,
    required this.image,
    required this.price,
    required this.kmDriven,
    required this.fuelType,
    required this.transmission,
    required this.owner,
    required this.emi,
    required this.location,
  });
}

class BuyCarPage extends StatefulWidget {
  const BuyCarPage({super.key});

  @override
  State<BuyCarPage> createState() => _BuyCarPageState();
}




class _BuyCarPageState extends State<BuyCarPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _preLovedKey = GlobalKey();
  final List<String> carImages = [
    'assets/Cars/lamborghini.jpg',
    'assets/Cars/mustang.png',
    'assets/Cars/BMW.jpg',
    'assets/Cars/cadillac.jpg',
  ];
  late List<CarModel> recentlyViewedCars;
  final TextEditingController searchController = TextEditingController();
  String searchText = "";


  final List<CarModel> allCars = [
    CarModel(
      title: 'Hyundai i20',
      brand: 'Hyundai',
      image: 'assets/Cars/car1.jpg',
      price: '₹4,49,000',
      kmDriven: '85,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹12,324/m',
      location: 'Delhi',
    ),
    CarModel(
      title: 'Honda City',
      brand: 'Honda',
      image: 'assets/Cars/Honda City.png',
      price: '₹6,50,000',
      kmDriven: '30,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹12,324/m',
      location: 'Kanpur',
    ),
    CarModel(
      title: 'Hyundai Creta SX Plus ',
      brand: 'Hyundai',
      image: 'assets/Cars/Hyundai Creta.png',
      price: '₹7,84,000',
      kmDriven: '78,000 km',
      fuelType: 'Petrol',
      transmission: 'Auto',
      owner: '2nd Owner',
      emi: '₹15,324/m',
      location: 'Bhopal',
    ),
    CarModel(
      title: 'Hyundai Aura',
      brand: 'Hyundai',
      image: 'assets/Cars/Hyundai Aura.png',
      price: '₹5,35,000',
      kmDriven: '10,0000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹20,324/m',
      location: 'Indore',
    ),
    CarModel(
      title: 'Honda Elevate',
      brand: 'Honda',
      image: 'assets/Cars/Honda Elevate.png',
      price: '₹6,49,000',
      kmDriven: '32,000 km',
      fuelType: 'Petrol',
      transmission: 'Auto',
      owner: '2nd Owner',
      emi: '₹12,324/m',
      location: 'Mumbai',
    ),
    CarModel(
      title: 'Range Rover',
      brand: 'Land Rover',
      image: 'assets/Cars/Land Rover (Range Rover).png',
      price: '₹45,99,000',
      kmDriven: '1,00,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '3rd Owner',
      emi: '₹55,324/m',
      location: 'Bangalore',
    ),
    CarModel(
      title: 'Scorpio',
      brand: 'Mahindra',
      image: 'assets/Cars/Mahindra Scorpio.png',
      price: '₹10,49,000',
      kmDriven: '90,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹25,324/m',
      location: 'Rewa',
    ),
    CarModel(
      title: 'Kwid',
      brand: 'Renault',
      image: 'assets/Cars/Renault Kwid.png',
      price: '₹3,49,000',
      kmDriven: '35,000 km',
      fuelType: 'Petrol',
      transmission: 'Auto',
      owner: '2nd Owner',
      emi: '₹8,324/m',
      location: 'Satna',
    ),
    CarModel(
      title: 'Tiber',
      brand: 'Renault',
      image: 'assets/Cars/Renault Tiber.png',
      price: '₹4,35,000',
      kmDriven: '10,0000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹19,324/m',
      location: 'Kolkata',
    ),
    CarModel(
      title: 'Desire',
      brand: 'Suzuki',
      image: 'assets/Cars/Suzuki Desire.png',
      price: '₹4,49,000',
      kmDriven: '1,00,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '3rd Owner',
      emi: '₹8,324/m',
      location: 'Goa',
    ),
    CarModel(
      title: 'Grand Vitra',
      brand: 'Suzuki',
      image: 'assets/Cars/suzuki Grandvitra.png',
      price: '₹6,49,000',
      kmDriven: '85,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹15,324/m',
      location: 'Nagpur',
    ),
    CarModel(
      title: 'Ignis',
      brand: 'Suzuki',
      image: 'assets/Cars/Suzuki Ignis.png',
      price: '₹2,49,000',
      kmDriven: '90,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹4,324/m',
      location: 'chennai',
    ),
    CarModel(
      title: 'S-Presso',
      brand: 'Suzuki',
      image: 'assets/Cars/suzuki S-press.png',
      price: '₹1,49,000',
      kmDriven: '85,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹4,324/m',
      location: 'Kanpur',
    ),
    CarModel(
      title: 'Wagon R',
      brand: 'Suzuki',
      image: 'assets/Cars/Suzuki WaganoR.png',
      price: '₹3,49,000',
      kmDriven: '1,00,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹5,324/m',
      location: 'Prayagraj',
    ),
    CarModel(
      title: 'Altroz',
      brand: 'Tata',
      image: 'assets/Cars/Tata Altroz.png',
      price: '₹2,20,000',
      kmDriven: '1,20,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹10,324/m',
      location: 'Lucknow',
    ),
    CarModel(
      title: 'Tata Punch',
      brand: 'Tata',
      image: 'assets/Cars/Tata Punch.png',
      price: '₹3,15,000',
      kmDriven: '3,00,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹5,324/m',
      location: 'Ayodhya',
    ),
    CarModel(
      title: 'Tata Tigor',
      brand: 'Tata',
      image: 'assets/Cars/Tata Tigor.png',
      price: '₹3,50,000',
      kmDriven: '5,20,000 km',
      fuelType: 'Petrol',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹8,324/m',
      location: 'Ghaziabad',
    ),
    CarModel(
      title: 'Innova',
      brand: 'Toyota',
      image: 'assets/Cars/Toyoto Nnnova.png',
      price: '₹25,35,000',
      kmDriven: '5,25,000 km',
      fuelType: 'Diesel',
      transmission: 'Auto',
      owner: '2nd Owner',
      emi: '₹45,324/m',
      location: 'Bhopal',
    ),
    CarModel(
      title: 'Virtus',
      brand: 'Volkswagen',
      image: 'assets/Cars/Volkswegen Virtus.png',
      price: '₹10,49,000',
      kmDriven: '65,000 km',
      fuelType: 'Petrol',
      transmission: 'Auto',
      owner: '2nd Owner',
      emi: '₹25,324/m',
      location: 'Hyderabad',
    ),
    CarModel(
      title: 'Meridian',
      brand: 'Jeep',
      image: 'assets/Cars/Jeep Meridian.png',
      price: '₹15,49,000',
      kmDriven: '60,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹25,324/m',
      location: 'Noida',
    ),
    CarModel(
      title: 'Safari Strome',
      brand: 'Tata',
      image: 'assets/Cars/Safari Strome.png',
      price: '₹16,49,000',
      kmDriven: '1,21,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹45,324/m',
      location: 'Kolkata',
    ),
    CarModel(
      title: 'Xuv 500',
      brand: 'Mahindra',
      image: 'assets/Cars/XUV500.png',
      price: '₹10,49,000',
      kmDriven: '1,00,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹25,324/m',
      location: 'Mumbai',
    ),
    CarModel(
      title: 'TrailBlazer',
      brand: 'Chevrolet',
      image: 'assets/Cars/TrailBlazer.png',
      price: '₹20,49,000',
      kmDriven: '3,25,000 km',
      fuelType: 'Diesel',
      transmission: 'Manual',
      owner: '2nd Owner',
      emi: '₹1,00,324/m',
      location: 'Bhopal',
    ),


    // Add 20+ cars here......
  ];

  @override
  void initState() {
    super.initState();

    // 🔥 Firestore test write
    FirebaseFirestore.instance
        .collection('test')
        .add({'message': 'DriveIn Firebase Connected!', 'timestamp': DateTime.now()})
        .then((docRef) {
      print('✅ Test Firestore write successful: ${docRef.id}');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firebase connected successfully!'))
      );
    })
        .catchError((error) {
      print('❌ Firestore write failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firebase connection failed!'))
      );
    });

    recentlyViewedCars = [
      allCars[0],
      allCars[1],
      allCars[2],
    ];
  }

  final List<Map<String, String>> carBrands = [
    {'name': 'All', 'logo': 'assets/Logo/car_icon.png'},
    {'name': 'Hyundai', 'logo': 'assets/Logo/hundai.png'},
    {'name': 'Suzuki', 'logo': 'assets/Logo/Suzuki.jpg'},
    {'name': 'Honda', 'logo': 'assets/Logo/Honda.png'},
    {'name': 'Toyota', 'logo': 'assets/Logo/toyota-logo.png'},
    {'name': 'Kia', 'logo': 'assets/Logo/kia icon.jpg'},
    {'name': 'Mahindra', 'logo': 'assets/Logo/Mahindra.png'},
    {'name': 'Tata', 'logo': 'assets/Logo/Tata-logo.png'},
    {'name': 'Volkswagen', 'logo': 'assets/Logo/Volkswagen-logo.png'},
    {'name': 'Renault', 'logo': 'assets/Logo/Renault-logo.png'},
    {'name': 'Ford', 'logo': 'assets/Logo/ford-logo-.png'},
  ];

  String selectedBrand = 'All';

  List<CarModel> get filteredCars {
    final brandFiltered = selectedBrand == 'All'
        ? allCars
        : allCars.where((car) =>
    car.brand.toLowerCase() == selectedBrand.toLowerCase()).toList();

    if (searchText.isEmpty) return brandFiltered;

    return brandFiltered
        .where((car) => car.title.toLowerCase().contains(searchText))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Buy Used Cars"),
        backgroundColor: Colors.blue[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Wishlist button clicked")));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildImageCarousel(),
              const SizedBox(height: 20),
              _buildViewAllButton(),
              const SizedBox(height: 20),
              _buildBrandFilter(),
              const SizedBox(height: 20),
              _buildRecentlyViewed(),
              const SizedBox(height: 20),
              _buildHelpBanner(),
              const SizedBox(height: 20),
              _buildPreLovedSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(4, 4)),
            const BoxShadow(
                color: Colors.white, blurRadius: 10, offset: Offset(-4, -4)),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  // when user presses enter
                  if (_preLovedKey.currentContext != null) {
                    Scrollable.ensureVisible(
                      _preLovedKey.currentContext!,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search your dream car...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildImageCarousel() =>
      CarouselSlider(
        options: CarouselOptions(
            height: 190.0, autoPlay: true, enlargeCenterPage: true),
        items: carImages.map((imgPath) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
                imgPath, width: double.infinity, fit: BoxFit.cover),
          );
        }).toList(),
      );

  Widget _buildViewAllButton() =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Scrollable.ensureVisible(
              _preLovedKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text("View all cars", style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
  Widget _buildPreLovedSection() => Container(
    key: _preLovedKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '20 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextSpan(text: 'PRE-LOVED CARS', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildPreLovedCars(),
      ],
    ),
  );

  Widget _buildBrandFilter() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Popular Car Brands",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: carBrands.length,
              itemBuilder: (context, index) {
                final brand = carBrands[index];
                return GestureDetector(
                  onTap: () => setState(() => selectedBrand = brand['name']!),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedBrand == brand['name'] ? Colors.blue
                          .shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2), blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(brand['logo']!, width: 40, height: 40),
                        const SizedBox(height: 4),
                        Text(brand['name']!,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget _buildRecentlyViewed() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recently viewed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...recentlyViewedCars.map((car) =>
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200,
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.asset(car.image, width: 130,
                          height: 100,
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(car.title, style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(car.price, style: TextStyle(color: Colors.green
                                .shade700, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.favorite_border, color: Colors.grey),
                      onPressed: () {
                        // 🔄 Add Firebase logic here later
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Wishlist icon tapped")),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              )),
        ],
      );


  Widget _buildHelpBanner() =>
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Logo/car_poster2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Need Help Buying?', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54),
                    onPressed: () {},
                    child: const Text('Talk to our Expert', style: TextStyle(
                        fontSize: 15, color: Colors.tealAccent)),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildPreLovedTitle() =>
      const Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '20 ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextSpan(text: 'PRE-LOVED CARS',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 18)),
            ],
          ),
        ),
      );

  Widget _buildPreLovedCars() {
    if (filteredCars.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: const Center(
          child: Text('Result not found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
      );
    }

    return Column(
      children: filteredCars.map((car) =>
          GestureDetector(
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarDetailPage(car: car, allCars: allCars),
                  ),
                ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                    child: Image.asset(car.image, height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(car.title,
                            style: const TextStyle(fontWeight: FontWeight
                                .bold)),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 10,
                          children: [
                            Text(car.kmDriven),
                            Text(car.fuelType),
                            Text(car.transmission),
                            Text(car.owner),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("EMI ${car.emi}", style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(car.price, style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(car.location),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )).toList(),
    );
  }
}//
// End of State class
