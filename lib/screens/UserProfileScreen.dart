import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String gender = "Male";
  bool locationAccess = true;
  String selectedTimeZone = "Asia/Kolkata";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? "John Doe";
      _emailController.text = prefs.getString('email') ?? "john@example.com";
      _phoneController.text = prefs.getString('phone') ?? "+91 9876543210";
      _dobController.text = prefs.getString('dob') ?? "1995-05-20";
      gender = prefs.getString('gender') ?? "Male";
      selectedTimeZone = prefs.getString('timezone') ?? "Asia/Kolkata";
      locationAccess = prefs.getBool('locationAccess') ?? true;
    });
  }

  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('dob', _dobController.text);
    await prefs.setString('gender', gender);
    await prefs.setString('timezone', selectedTimeZone);
    await prefs.setBool('locationAccess', locationAccess);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile & Settings"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/profile_placeholder.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Upload/change profile pic logic
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            // Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email Address"),
            ),

            // Phone
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            // DOB
            TextField(
              controller: _dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date of Birth",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.tryParse(_dobController.text) ??
                          DateTime(1995, 5, 20),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dobController.text =
                            pickedDate.toIso8601String().split("T").first;
                      });
                    }
                  },
                ),
              ),
            ),

            // Gender
            DropdownButtonFormField<String>(
              value: gender,
              items: ["Male", "Female", "Other"].map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              onChanged: (val) => setState(() => gender = val!),
              decoration: const InputDecoration(labelText: "Gender"),
            ),

            const SizedBox(height: 20),

            // Time Zone
            DropdownButtonFormField<String>(
              value: selectedTimeZone,
              items: ["Asia/Kolkata", "America/New_York", "Europe/London"]
                  .map((tz) {
                return DropdownMenuItem(value: tz, child: Text(tz));
              }).toList(),
              onChanged: (val) => setState(() => selectedTimeZone = val!),
              decoration: const InputDecoration(labelText: "Time Zone"),
            ),

            // Location Access Switch
            SwitchListTile(
              title: const Text("Location Access"),
              value: locationAccess,
              onChanged: (val) => setState(() => locationAccess = val),
            ),

            const Divider(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Change password logic
              },
              icon: const Icon(Icons.lock),
              label: const Text("Change Password"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Logout all devices logic
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout from All Devices"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Delete account logic
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text("Delete Account"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),

            const Divider(height: 30),

            ListTile(
              title: const Text("Privacy Policy"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Open privacy policy link
              },
            ),
            ListTile(
              title: const Text("FAQs"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Open FAQs page
              },
            ),
            ListTile(
              title: const Text("Feedback"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Open feedback form
              },
            ),
          ],
        ),
      ),
    );
  }
}
