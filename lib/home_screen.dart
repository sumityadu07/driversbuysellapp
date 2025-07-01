
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:driven/BuyCarPage.dart';
import 'package:driven/SellCarPage.dart';
import 'package:driven/buy_insurance.dart';
import 'package:driven/get_loan.dart';
import 'package:driven/location_page.dart';
import 'package:driven/pay_challan.dart';
import 'package:driven/rto_check.dart';
import 'package:driven/scrap_car.dart';
import 'package:driven/vechile_history.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';
import 'credit_score.dart';
import 'driving_school.dart';
import 'fastag_car.dart';
import 'hire_driver.dart';
import 'manage_car.dart';
import 'new_car.dart';

class HomeScreen extends StatefulWidget {
  final String selectedCity;

  const HomeScreen({super.key, this.selectedCity = 'Select City'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedCity;
  }

  void _navigateToLocationPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationSelectionPage()),
    );

    if (result != null && result is String) {
      setState(() {
        selectedCity = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 530,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF000000), Color(0xFFC5796D)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),),
                  Container(height: MediaQuery.of(context).size.height, color: Colors.white60),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _navigateToLocationPage,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                selectedCity,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                          },
                          child: const Icon(Icons.account_circle_outlined, color: Colors.white),
                        ),
                      ]
                    ),

                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search to buy used cars',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildFeatureCard('Sell Car', 'Quickly list your car', 'assets/Icons/sell car icon.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SellCarPage()));
                        }),
                        _buildFeatureCard('Buy Used Car', 'Find affordable cars', 'assets/Icons/Buy used car icon.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BuyCarPage()));
                        },
                        ),
                        _buildFeatureCard('Get Loans', 'Low-interest options', 'assets/Icons/Get Loans.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GetLoanPage()));
                        }),
                        _buildFeatureCard('Buy Insurance', 'Secure your car', 'assets/Icons/Insurance icon.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BuyInsurancePage()));
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildSmallFeatureButton('assets/Icons/manage car.png', 'Manage Your Car', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageCarPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/new-car.png', 'New cars', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewCarPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/personal loan.png', 'Personal Loan', () {}),
                        _buildSmallFeatureButton('assets/Icons/fastag.png', 'FASTag', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FastagPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/New car PDI.png', 'New car PDI', () {}),
                        _buildSmallFeatureButton('assets/Icons/pay buy car check.png', 'Pre buy car check', () {}),
                        _buildSmallFeatureButton('assets/Icons/used car-loan.png', 'Used car Loan', () {}),
                        _buildSmallFeatureButton('assets/Icons/pay challan.png', 'Pay Challan', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaychallanPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/credit-score.png', 'Credit score', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreditscorePage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/Get insurance.png', 'Get insurance', () {}),
                        _buildSmallFeatureButton('assets/Icons/vehcile history.png', 'Vehicle history', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VechilehistoryPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/scrapping car.png', 'Scrap car', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ScrapcarPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/hire driver.png', 'Hire driver', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HiredriverPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/RTO check.png', 'RTO check', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RtocheckPage()));
                        }),
                        _buildSmallFeatureButton('assets/Icons/loan against car.png', 'Loan against car', () {}),
                        _buildSmallFeatureButton('assets/Icons/driving school.png', 'Driving school', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DrivingschoolPage()));

                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/Images/promo_banner.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Happy Customers Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Happy Customers',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 400,
                            child: CustomerReviewCarousel()), // ✅ Use new carousel here
                      ],
                    ),
                  ),



                  const SizedBox(height: 36),

                  /// Our Services Section in a Row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Our Services', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services.png',
                          title: 'Drive home your \ndream car',
                          subtitle: "Buy",
                          features: ['140+ quality checks', '7-day return', 'Finance it your way'],
                          buttonText: 'View all cars',
                        ),
                        const SizedBox(width: 15),
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services2.png',
                          title: 'Check your Credit Score\nfor free',
                          subtitle: 'CREDIT SCORE',
                          features: ['Free score check', 'No impact on score', 'Personalised credit tips'],
                          buttonText: 'Check Now',
                        ),
                        const SizedBox(width: 15),
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services3.png',
                          title: 'Make your dreams real\nwith a personal loan',
                          subtitle: 'LOANS24',
                          features: ['Attractive interest rate', 'Quick approval', 'Get upto 10Lakh'],
                          buttonText: 'Apply Now',
                        ),
                        const SizedBox(width: 15),
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services4.png',
                          title: 'Trust us to\nsell your car',
                          subtitle: 'SELL',
                          features: ['Best price', 'Instant payment', 'Hassle-free documentations'],
                          buttonText: 'Get car price',
                        ),
                        const SizedBox(width: 15),
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services5.png',
                          title: 'Make your dream\ncar a reality',
                          subtitle: 'FINANCE',
                          features: ['Tenure uo to 6yrs', '0 down payment', "Flexible EMI's"],
                          buttonText: 'Check eligibility in 2 min',
                        ),
                        const SizedBox(width: 15),
                        _buildNewServiceCard(
                          imagePath: 'assets/Images/Our services6.png',
                          title: 'Your guide to safer\nroads',
                          subtitle: 'ROAD SAFETY',
                          features: ['Helpline numbers', 'Pothole patrol', 'Safety guides'],
                          buttonText: 'Learn more',

                        ),
                      ],
                    ),
                  ),


                  /// Founders Section
                  const SizedBox(height: 32),
                  FoundersSection(),

                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, String subtitle, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallFeatureButton(String iconPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(iconPath, height: 40),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildCustomerCard({required String imagePath, required String name, required String review}) {
    return Container(
      height: 200,
      width: 200,
      margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(radius: 30, backgroundImage: AssetImage(imagePath)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(review),
      ),
    );
  }

  Widget _buildNewServiceCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required List<String> features,
    required String buttonText,
  }) {
    return  SizedBox(
      width: 300,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 280),
                ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  for (var feature in features)
                    Row(
                      children: [
                        const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                        const SizedBox(width: 6),
                        Expanded(child: Text(feature, style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BuyCarPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(buttonText),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CustomerCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final int rating;
  final String review;

  const CustomerCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(location, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                rating,
                    (index) => const Icon(Icons.star, color: Colors.orange, size: 16),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              review,
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

final List<CustomerCard> customerCards = [
  CustomerCard(
    imageUrl: 'assets/Images/coustomer1.jpg',
    name: 'Deepti Singh',
    location: 'Bhopal',
    rating: 5,
    review: 'DriveIn made it so easy to sell my car  . Loved it!',
  ),
  CustomerCard(
    imageUrl: 'assets/Images/coustomer.jpg',
    name: 'Satwik Upadhyay',
    location: 'Indore',
    rating: 4,
    review: 'Got my car loan instantly. Highly recommended!',
  ),
  CustomerCard(
    imageUrl: 'assets/Images/c.jpg',
    name: 'RajKumar Singh',
    location: 'Mumbai',
    rating: 4,
    review: '"Bought a second-hand car and it was as good as new. Loved the quality checks and support."',
  ),
  CustomerCard(
  imageUrl: 'assets/Images/coustomer8.jpg',
  name: 'Rohan Singh',
  location: 'Mumbai',
  rating: 5,
  review: "Excellent app! I got my car insured without any paperwork hassle. Must-have for car owners."
  )
  ];

class CustomerReviewCarousel extends StatelessWidget {
   const CustomerReviewCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.75,
      ),
      items: customerCards.map((card) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
                  radius: 105,
                  backgroundImage: AssetImage(card.imageUrl),
                ),
              ),
              const SizedBox(height: 10),
              Text(card.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(card.location, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  card.rating,
                      (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                card.review,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
class FoundersSection extends StatelessWidget {
  final List<Map<String, String>> founders = [
    {
      'name': 'Shashank Singh\n Founder & CEO',
      'image': 'assets/Founders/Shashank.png',
    },
    {
      'name': 'Anurag Singh Bhadauriya\n Co-Founder & CTO',
      'image': 'assets/Founders/anurag.jpg',
    },
    {
      'name': 'Mayank Shukla\n Co-Founder & CFO ',
      'image': 'assets/Founders/founder.jpg',
    },
    {
      'name': 'Abhinav Dhar Dwivedi\n Co-Founder & CMO',
      'image': 'assets/Founders/founder3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            'Our Founders',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: founders.length,
            itemBuilder: (context, index) {
              final founder = founders[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: FadeInRight(
                  duration: Duration(milliseconds: 500 + index * 300),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(founder['image']!),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          founder['name']!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
