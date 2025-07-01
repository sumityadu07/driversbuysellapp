import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:driven/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? uid;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        name = user.displayName ?? doc.data()?['name'] ?? 'No Name';
        uid = user.uid;
        imageUrl = doc.data()?['imageUrl'];
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final user = FirebaseAuth.instance.currentUser;

    if (pickedFile != null && user != null) {
      final storageRef = FirebaseStorage.instance.ref().child('user_images/${user.uid}.jpg');
      await storageRef.putFile(File(pickedFile.path));
      final url = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'imageUrl': url,
      }, SetOptions(merge: true));

      setState(() {
        imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : const AssetImage('assets/Logo/Logo.png') as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name ?? 'Loading...',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Driver ID: ${uid ?? 'Loading...'}'),
                  TextButton(
                    onPressed: _pickAndUploadImage,
                    child: const Text('Edit Profile'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Cars Bought', '3'),
                _buildStatCard('Cars Sold', '1'),
                _buildStatCard('Credit Score', '783'),
              ],
            ),
            const SizedBox(height: 24),

            const Text('My Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildListTile(Icons.directions_car, 'My Listings', () {}),
            _buildListTile(Icons.shopping_cart, 'My Purchases', () {}),
            _buildListTile(Icons.account_balance_wallet, 'My Loans / EMI', () {}),
            _buildListTile(Icons.security, 'Insurance Details', () {}),
            _buildListTile(Icons.history, 'Car History', () {}),
            const SizedBox(height: 24),

            const Text('Account Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildListTile(Icons.lock, 'Change Password', () {}),
            _buildListTile(Icons.location_on, 'Address Book', () {}),
            _buildListTile(Icons.phone_android, 'Linked Phone / Email', () {}),
            _buildListTile(Icons.notifications, 'Notification Preferences', () {}),
            const SizedBox(height: 24),

            const Text('Help & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildListTile(Icons.help, 'FAQs', () {}),
            _buildListTile(Icons.phone, 'Contact Support', () {}),
            _buildListTile(Icons.report_problem, 'Report an Issue', () {}),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: const Text('Terms')),
                TextButton(onPressed: () {}, child: const Text('Privacy')),
              ],
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const CarThemeLoginPage()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
