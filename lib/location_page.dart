import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> allCities = [
    "Mumbai",       "Delhi",         "Bangalore",    "Hyderabad",     "Chennai",
    "Kolkata",      "Pune",          "Ahmedabad",    "Jaipur",        "Lucknow",
    "Kanpur",       "Nagpur",        "Indore",       "Bhopal",        "Visakhapatnam",
    "Patna",        "Vadodara",      "Ghaziabad",    "Ludhiana",      "Agra",
    "Nashik",       "Faridabad",     "Meerut",       "Rajkot",        "Kalyan-Dombivli",
    "Vasai-Virar",  "Varanasi",      "Srinagar",     "Aurangabad",    "Dhanbad",
    "Amritsar",     "Navi Mumbai",   "Allahabad",    "Ranchi",        "Howrah",
    "Coimbatore",   "Jabalpur",      "Gwalior",      "Vijayawada",    "Jodhpur",
    "Madurai",      "Raipur",        "Kota",         "Chandigarh",    "Guwahati",
    "Solapur",      "Hubli-Dharwad", "Bareilly",     "Moradabad",     "Mysore",
    "Tiruchirappalli", "Tiruppur",   "Bhubaneswar",  "Salem",         "Warangal",
    "Guntur",       "Bhiwandi",      "Saharanpur",   "Gorakhpur",     "Bikaner",
    "Amravati",     "Noida",         "Jamshedpur",   "Bhilai",        "Cuttack",
    "Firozabad",    "Kochi",         "Nellore",      "Bhavnagar",     "Dehradun",
    "Durgapur",     "Asansol",       "Rourkela",     "Nanded",        "Kolhapur",
    "Ajmer",        "Akola",         "Gulbarga",     "Jamnagar",      "Ujjain",
    "Loni",         "Siliguri",      "Jhansi",       "Ulhasnagar",    "Jammu",
    "Sangli-Miraj & Kupwad", "Mangalore", "Erode",  "Belgaum",       "Kurnool",
    "Ambattur",     "Tirunelveli",   "Malegaon",     "Gaya",          "Jalgaon",
    "Udaipur",      "Maheshtala",    "Tirupati",     "Davanagere",    "Kozhikode",
    "Bokaro",       "South Dumdum"

  ];

  List<String> popularCities = ["Mumbai", "Delhi", "Bangalore", "Hyderabad", "Chennai", "Ahmedabad", "Lucknow", "Indore", "Bhopal", "Noida", "Kolkata", "Gurgaon", "Pune", "Faridabad", "Ghaziabad", "Rewa", "Jaipur"];
  List<String> filteredCities = [];
  String selectedCity = "";

  @override
  void initState() {
    super.initState();
    filteredCities = List.from(allCities);
  }

  void _filterCities(String query) {
    setState(() {
      filteredCities = allCities.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Select Your City"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search city...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onChanged: _filterCities,
            ),
            SizedBox(height: 16),
            Text("Popular Cities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularCities.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      final selectedCity = popularCities[index];
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isCitySelected', true);
                      await prefs.setString('selectedCity', selectedCity);

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomeScreen(selectedCity: selectedCity)),
                            (route) => false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage("assets/Images/${popularCities[index]}.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            popularCities[index],
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text("Other Cities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredCities[index]),
                    onTap: () {
                      setState(() {
                        selectedCity = filteredCities[index];
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomeScreen(selectedCity: selectedCity)),
                            (route) => false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
