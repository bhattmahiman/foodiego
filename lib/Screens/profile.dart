import 'package:flutter/material.dart';
import 'package:foodiego/Screens/splash_screen.dart';
import 'package:foodiego/widgets/add_address_dialog.dart';
import 'package:foodiego/widgets/edit_field_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> editProfileField({
    required String title,
    required String currentValue,
    required Function(String) onSave,
  }) async {
    final isEmail = title == "Email";

    final value = await showDialog<String>(
      context: context,
      builder: (_) => EditFieldDialog(
        title: title,
        subtitle: isEmail ? "Update your email address" : "Update your name",
        initialValue: currentValue,
        icon: isEmail ? Icons.mail_outline : Icons.person_outline,
        keyboardType:
        isEmail ? TextInputType.emailAddress : TextInputType.name,
        textCapitalization:
        isEmail ? TextCapitalization.none : TextCapitalization.words,
        validator: isEmail
            ? (v) => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)
            ? null
            : "Enter a valid email address"
            : null,
      ),
    );

    if (!mounted || value == null || value.isEmpty) return;

    onSave(value);
  }

  // Opens the same "Add Delivery Address" dialog used in Checkout.
  Future<void> _changeAddress() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => const AddAddressDialog(),
    );

    if (!mounted || result == null) return;

    setState(() {
      addressName = result['name'];
      addressDetails = result['details'];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Address saved")),
    );
  }

  String name = "Mahiman";
  String email = "mahiman@gmail.com";
  String? addressName;
  String? addressDetails;

  final List<Map<String, dynamic>> profileList = [
    {
      "name": "Notification",
      "icon": Icons.notifications,
    },
    {
      "name": "Change Address",
      "icon": Icons.my_location_outlined,
    },
    {
      "name": "Password Update",
      "icon": Icons.lock,
    },
    {
      "name": "Help",
      "icon": Icons.help,
    },
    {
      "name": "Terms & Condition",
      "icon": Icons.policy,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              const SizedBox(height: 30),

              CircleAvatar(
                radius: 90,
                child: ClipOval(
                  child: Image.network(
                    'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNy00MDMucG5n.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 80);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  editProfileField(
                    title: "Name",
                    currentValue: name,
                    onSave: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  );
                },
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 46,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  editProfileField(
                    title: "Email",
                    currentValue: email,
                    onSave: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  );
                },
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: ListView.builder(
                  itemCount: profileList.length,
                  itemBuilder: (context, index) {
                    final itemName = profileList[index]["name"] as String;
                    final isAddress = itemName == "Change Address";

                    return ListTile(
                      leading: Icon(
                        profileList[index]["icon"] as IconData,
                      ),
                      title: Text(
                        itemName,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      // Show the saved address under the "Change Address" tile.
                      subtitle: isAddress && addressDetails != null
                          ? Text(
                        "$addressName: $addressDetails",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                          : null,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        if (isAddress) {
                          _changeAddress();
                        }
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen(),));
                  },
                  label: const Text("Logout"),
                  icon: const Icon(Icons.logout),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD94005),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}